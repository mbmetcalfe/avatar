import re, tf, json, yaml
from collections import deque

remove_parens = re.compile("\([^\)]*\) ")
color_escapes = re.compile(r"\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]")
av_colors = re.compile(r'\|[ngrbycpkwNGRBYCPKWase]{1,4}\|')

stab = {
#    "A sparrow is here.": {
#    "delay": 2
#    }
}

tf.eval("/echo GMCP Init.")

stabs = {}
tf.eval("/echo Loading stab targets (stabs.yaml).")
with open('stabs.yaml') as f:
    stabs = yaml.safe_load(f)
tf.eval("/echo -pw @{hCcyan}[GMCP INFO]: %d stab targets loaded." % len(stabs))

stomps = {}
tf.eval("/echo Loading stomp targets (stomps.yaml).")
with open('stomps.yaml') as f:
    stomps = yaml.safe_load(f)
tf.eval("/echo -pw @{hCcyan}[GMCP INFO]: %d stomp targets loaded." % len(stomps))

ammo_area = ""
tf.eval("/echo Loading area ammo information (ammo_areas.yaml).")
with open('ammo_areas.yaml') as f:
    ammo_area = yaml.safe_load(f)
tf.eval("/echo -pw @{hCcyan}[GMCP INFO]: %d area ammo information loaded." % len(ammo_area))

area_ignore = ["System", "Sanctum"]

psi_weapons = {}
psi_weapons_by_name = {}
tf.eval("/echo Loading psi weapons (psi.yaml).")
with open("psi.yaml") as f:
    psi_weapons = yaml.safe_load(f)
tf.eval("/echo -pw @{hCcyan}[GMCP INFO]: %d psi weapons loaded." % len(psi_weapons))

for charname, weapon in psi_weapons.items():
    weapon['charname'] = charname
    psi_weapons_by_name[weapon['weapon_name']] = weapon

current_area = "NA"
stompers_in_room = set()

def gmcp_debug(line, force=False):
    if not force:
        tf.eval("/if ({gmcp_echo} =~ 'Y') /echo -p @{hCcyan}[GMCP DEBUG]: @{xCyellow}" + line + "@{n}%;/endif")
    else:
        tf.eval("/echo -p @{hCcyan}[GMCP DEBUG]: @{xCyellow}" + line + "@{n}")
    return

autotank_player = {}
autotank_q = {}
q = deque()
def addq(world, player, short):
    if autotank_player.get(world, 0):
        if world not in autotank_q:
            autotank_q[world] = deque()
        if short in stabs:
            delay = stabs[short]
            if stabs[short] == 0:
                autotank_q[world].append(player["name"])
            elif stabs[short] > 0:
                autotank_q[world].appendleft(player["name"])

def autotank(world):
    if autotank_player.get(world, 0):
        if world not in autotank_q:
            autotank_q[world] = deque()
        if len(autotank_q[world]) > 0:
            tf.eval("/echo -pw @{hCgreen}%d mobs in queue.@{n}" % (len(autotank_q[world])))
            mob = autotank_q[world].pop()
            tf.eval("ki %s" % (mob))

def parse_line(line):
    world, cmd, content = line.split(' ', 2)
    content = color_escapes.sub("", content)
    content = av_colors.sub("", content)
    
    j = None
    #tf.eval("/echo line: %s" % line)
    try:
      j = json.loads(content)
    except json.decoder.JSONDecodeError:
      tf.eval("/echo -p @{Cred}GMCP ERROR: failed to decode content from %s" % cmd)
      pass
    return world, cmd, j

def log_vitals(world, groupie):
    tf.eval("/sendlocal groupie:{}|{}|{}|{}|{}|{}".format(
        world,
        groupie["hp"],
        groupie["maxhp"],
        groupie["mp"],
        groupie["maxmp"],
        groupie.get("position", "**")))

def get_spell_duration(affect_line):
    # Catch the simple match.
    spell_dur_match = re.match(r'for ([0-9]+)', affect_line)
    if spell_dur_match:
        return spell_dur_match.groups()[0]
    # Determine the wordy version and a return a rough estimate.
    else:
        spell_dur_match = re.match(r'modifies .* for ([0-9]+)', affect_line)
        if spell_dur_match:
            return spell_dur_match.groups()[0]

        # try other variations, i.e. glorious conquest percentage
        spell_dur_match = re.match(r'by .* [0-9]+% for ([0-9]+) hours$', affect_line)
        if spell_dur_match:
            return spell_dur_match.groups()[0]
        
        wordy_spell_dur_match = re.match(r'^(seems|for) ([a-zA-Z\ ]+)$', affect_line)
        if wordy_spell_dur_match:
            spellDuration = wordy_spell_dur_match.groups()[1]
            if spellDuration == "seemingly forever":
                return "51"
            elif spellDuration == "a very long time":
                return "50"
            elif spellDuration == "a long time":
                return "25"
            elif spellDuration == "a while":
                return "10"
            elif spellDuration == "a small amount of time":
                return "5"
            elif spellDuration == "a tiny amount of time":
                return "4"
            elif spellDuration == "to be wavering":
                return "1"
            else:
                return spellDuration

        continuous_match = re.match(r'continuous', affect_line)
        if continuous_match:
            return "999"

        gmcp_debug("No spell duration match.")
        return affect_line

def Char_Status(world, status):
    area = status.get('area_name', None)
    affects = status.get("affects", None)
    global current_area
    if area:
        area_match = re.match(r'^\{[^\}]+\}\s+[^\s]*\s+(.*)', area)
        if area_match:
            area = area_match.groups()[0]
            current_area = area
        tf.eval("/echo -pw @{hCyellow}In %s" % area)
        if area not in area_ignore:
            ammo_type = ammo_area.get(area, "piercing")
            tf.eval("/ammo_swap -w%s %s" % (world, ammo_type))
    if affects:
        tf.eval("/tickset")
        tf.eval("/clearspelldurations")
        for affect in affects:
            spell_match = re.match(r'^Spell: ([a-zA-Z ]+)$', affect)
            poison_match = re.match(r'^Spell: (poison|toxin|biotoxin|venom|heartbane|doom toxin)$', affect)
            disease_match = re.match(r'^Spell: (virus|plague|necrotia)$', affect)
            deaths_door_match = re.match(r'^Spell: deaths door$', affect)
            web_match = re.match(r'^Spell: web$', affect)
            rupture_match = re.match(r'^Spell: rupture$', affect)
            sick_other_match = re.match(r'^Spell: (awe|calm|fear|scramble|curse|unrest|faerie fire)$', affect)
            racial_fatigue_match = re.match(r'^Racial ([a-zA-Z \-]+) fatigue', affect)
            skill_exhaust_match = re.match(r'^Exhausted Spell: ([a-zA-Z \-]+)$', affect)
# GMCP: Char.Status { "affects": { "Exhausted Spell: emu stance": "unavailable for 1 hours"
            
            if poison_match:
                gmcp_debug('Poison affect', True)
                #tf.eval("/set sick_poison=/test $[++sick_poison]")
                num_poison = int(tf.getvar("sick_poison", "0")) + 1
                #tf.out('sick_poison: ' % num_poison)
                tf.eval("/set sick_poison={}".format(num_poison))
            if disease_match:
                num_disease = int(tf.getvar("sick_disease", "0")) + 1
                gmcp_debug('Disease affect', True)
                #tf.eval("/set sick_disease=/test $[++sick_disease]")
                #tf.out('sick_disease: ' % str(num_disease))
                tf.eval("/set sick_disease={}".format(num_disease))
            if deaths_door_match:
                #tf.eval("/set sick_deathsdoor=/test $[++sick_deathsdoor]")
                tf.eval("/set sick_deathsdoor=1")
            if web_match:
                #tf.eval("/set sick_web=/test $[++sick_web]")
                tf.eval("/set sick_web=1")
            if rupture_match:
                #tf.eval("/set sick_rupture=/test $[++sick_rupture]")
                tf.eval("/set sick_rupture=1")
            if sick_other_match:
                tf.eval("/set sick_other=%s, %%{sick_other}" % sick_other_match.groups()[0])
            if racial_fatigue_match:
                fatigue_name = racial_fatigue_match.groups()[0]
                fatigue_duration = get_spell_duration((affects[affect]))
                try:
                    fatigue_duration_value = int(fatigue_duration)
                    tf_fatigue_var = fatigue_name.replace(" ", "") + "fatigue"
                    tf.eval("/set %s=%d" %(tf_fatigue_var, fatigue_duration_value))
                except ValueError:
                    gmcp_debug("%s duration is not an int: %s" % (fatigue_name, fatigue_duration))

            if spell_match:
                spell_name = spell_match.groups()[0]
                spell_duration = get_spell_duration((affects[affect]))
                try:
                    spell_duration_value = int(spell_duration)
                    gmcp_debug("%s: %s" % (spell_name, spell_duration_value))
                    tf_spell_var = spell_name.replace(" ", "") + "left"
                    tf.eval("/set %s=%d" %(tf_spell_var, spell_duration_value))
                except ValueError:
                    gmcp_debug("%s duration is not an int: %s" % (spell_name, spell_duration))
    tf.eval("/gmcp-char-status")

def Char_Vitals(world, data):
    log_vitals(world, data)
    # set status line variables
    tf.eval("/set myTnl=%s" % data['maxtnl'])
    tf.eval("/set curr_hp=%s" % data['hp'])
    tf.eval("/set max_hp=%s" % data['maxhp'])
    tf.eval("/set curr_mana=%s" % data['mp'])
    tf.eval("/set max_mana=%s" % data['maxmp'])
    tf.eval("/set curr_move=%s" % data['mv'])
    tf.eval("/set max_move=%s" % data['maxmv'])
    if (data['monhp'] == None):
        tf.eval("/set curr_mhp=-")
        tf.eval("/set max_mhp=-")
    else:
        tf.eval("/set curr_mhp=%s" % data['monhp'])
        tf.eval("/set max_mhp=%s" % data['maxmonhp'])
    # TODO: Fix status line to reduce these 4 lines to 2.
    tf.eval("/set mudLag=%s" % data['lag'])
    tf.eval("/set displayLag=Lag:%s" % data['lag'])
    tf.eval("/set tnl=%s" % data['tnl'])
    tf.eval('/set displayTNL=%s TNL' % data['tnl'])

def Char_Group_List(world, groupies):
    tf.eval("/sendlocal groupieclr:")
    for groupie in groupies:
        log_vitals(groupie["name"].lower(), groupie)
    tf.eval("/set grouplist=%s" % ' '.join([groupie["name"].lower() for groupie in groupies]))
    tf.eval("/set groupies=<%s<" % '<'.join([groupie['name'].lower() for groupie in groupies]))

def Room_RemovePlayer(world, j):
    tf.eval("/send-gmcp char.group.list")

    try:
        int(j)
        if world in autotank_q and len(autotank_q[world]) > 0 and j in autotank_q[world]:
            autotank_q[world].remove(j)
    except ValueError:
        pass
    
    # Try and remove mob from stompers in room list.
    stompers_in_room.discard(j)

    if len(stompers_in_room) > 0:
        tf.eval("/echo -pw Still STOMPERS??")

def Room_Info(world, j):
    tf.eval("/send-gmcp char.group.list")
    tf.eval("/setvar zone=%s" % j["zone"])

def Room_Players(world, players):
#    try:
#        stompers_in_room.clear()
#    except:
#        pass

    if world not in autotank_q:
        autotank_q[world] = deque()
    autotank_q[world].clear()

    try:
        autotank_player[world] = int(tf.getvar('%s_auto_tankbot' % world, 0))
    except ValueError:
        autotank_player[world] = 0
    tf.eval('/set %s_room_players= ' % world)
    for player in players.values():
        short = re.sub(remove_parens, "", player["fullname"])
        race = player["race"]
        tf.eval('/setvar room_players $(/getvar room_players) %s' % player["name"].lower())
        addq(world, player, short)
        try:
            int(player["name"])
            delay = stabs.get(short, None)
            if delay != None and delay >= 0:
                tf.eval("/chkassa -w%s %s %.2f" % (world, player["name"], delay))
            zone = tf.getvar("%s_zone" % world)
            if ', fighting ' not in short:
                tf.eval("/sendlocal mobile:{}|{}".format(zone, short))
                #tf.eval("/sendlocal mobile:{}|{}|{}".format(zone, short, race))
        except ValueError:
            # not a mob
            pass

        if short in stomps:
            stompers_in_room.add(player["name"])
            tf.eval("/beep")
            tf.eval("/echo -pw Stomping mob: %s - %s." % (short, player["name"]))
            
    autotank(world)

    if len(stompers_in_room) > 0:
        tf.eval("/beep")
#        tf.eval("/if ({myclass} =~ 'psi' & {mytier} =~ 'lord') /setMySpell mindwipe%;/endif")

def Room_AddPlayer(world, players):
    try:
        autotank_player[world] = int(tf.getvar('%s_auto_tankbot' % world, 0))
    except ValueError:
        autotank_player[world] = 0

    for player in players.values():
        short = re.sub(remove_parens, "", player["fullname"])
        tf.eval('/setvar room_players $(/getvar room_players) %s' % player["name"].lower())
        addq(world, player, short)
        delay = stabs.get(short, None)
        # Stab and auto-tank
        if delay != None and delay >= 0:
            tf.eval("/chkassa -w%s %s %.2f" % (world, player["name"], delay))
        try:
            i = int(player["name"])
            if len(q) < 2:
                autotank(world)
        except:
            pass

        zone = tf.getvar("%s_zone" % world)
        # Log mobiles to the db
        if player["name"].isdigit():
            tf.eval("/sendlocal mobile:{}|{}".format(zone, short))
        if short in stomps:
            stompers_in_room.add(player["name"])
            for mob in stompers_in_room:
                tf.eval("/echo -pw Stomping mob: %s - %s" % (short, player["name"]))
                tf.eval("/beep")

def Char_Items_Add(world, add):
    location = add.get('location', '')
    if location == 'room':
        item = add.get('item', {})
        item_name = item.get('name')
#        if item_name == 'a blood pool':
#            tf.eval("/echo -pw @{hCred}You got pools!@{n}")

        weapon_name = item.get('name')
        weapon = psi_weapons_by_name.get(weapon_name)
        if weapon:
            charname = weapon.get('charname')
            if weapon.get('weapons'):
                if charname.lower() != world.lower():
                    givestr = '='.join(['get {}=give {} {}' .format(w, w, charname) for w in weapon.get('weapons')])
                else:
                    givestr = '='.join(['get {}' .format(w, w, charname) for w in weapon.get('weapons')])
                tf.eval("/send -w%s %s" % (world, givestr))


def trigger(arg):
    line = arg
    
    world, cmd, j = parse_line(line)
    if not j:
        return
    cmd_rep = cmd.replace('.', '_')
    if cmd_rep in globals():
        globals()[cmd_rep](world, j)
    else:
        #tf.eval("/echo %s is not an implemented command" % cmd)
        pass
