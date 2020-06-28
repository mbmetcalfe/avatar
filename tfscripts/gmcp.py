import re, tf, json, yaml

remove_parens = re.compile("\([^\)]*\) ")

tf.eval("/echo GMCP Init.")

stabs = {}
tf.eval("/echo Loading stab targets (stabs.yaml).")
with open('stabs.yaml') as f:
    stabs = yaml.safe_load(f)
tf.eval("/echo Stab targets loaded.")

ammo_area = ""
tf.eval("/echo Loading area ammo information (ammo_areas.yaml).")
with open('ammo_areas.yaml') as f:
    ammo_area = yaml.safe_load(f)
tf.eval("/echo Area ammo information loaded.")

area_ignore = ["System", "Sanctum"]

def gmcp_debug(line, force=False):
    if not force:
        tf.eval("/if ({gmcp_echo} =~ 'Y') /echo -p @{hCcyan}[GMCP DEBUG]: @{xCyellow}" + line + "@{n}%;/endif")
    else:
        tf.eval("/echo -p @{hCcyan}[GMCP DEBUG]: @{xCyellow}" + line + "@{n}")
    return

def parse_line(line):
    world, cmd, content = line.split(' ', 2)
    j = None
    #tf.eval("/echo line: %s" % line)
    try:
      j = json.loads(content)
    except json.decoder.JSONDecodeError:
      #tf.eval("/echo failed to decode content from %s" % cmd)
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
    spell_dur_match = re.match(r'for ([0-9]+)', affect_line)
    if spell_dur_match:
        return spell_dur_match.groups()[0]
    else:
        spell_dur_match = re.match(r'modifies .* for ([0-9]+)', affect_line)
        if spell_dur_match:
            return spell_dur_match.groups()[0]

        gmcp_debug("No spell duration match.")
        return affect_line

def Char_Status(world, status):
    area = status.get('area_name', None)
    affects = status.get("affects", None)
    if area:
        area_match = re.match(r'^\{[^\}]+\}\s+[^\s]*\s+(.*)', area)
        if area_match:
            area = area_match.groups()[0]
        tf.eval("/echo -p @{hCyellow}In %s" % area)
        if area not in area_ignore:
            ammo_type = ammo_area.get(area, "piercing")
            tf.eval("/ammo_swap -w%s %s" % (world, ammo_type))
    if affects:
        gmcp_debug("We have some affects.")
        tf.eval("/tickset")
        tf.eval("/clearspelldurations")
        for affect in affects:
            spell_match = re.match(r'^Spell: ([a-zA-Z ]+)$', affect)

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
    tf.eval("/set myTNL=%s" % data['maxtnl'])
    tf.eval("/set curr_hp=%s" % data['hp'])
    tf.eval("/set max_hp=%s" % data['maxhp'])
    tf.eval("/set curr_mana=%s" % data['mp'])
    tf.eval("/set max_mana=%s" % data['maxmp'])
    tf.eval("/set curr_move=%s" % data['mv'])
    tf.eval("/set max_move=%s" % data['maxmv'])
    # TODO: Fix status line to reduce these 4 lines to 2.
    tf.eval("/set mudLag=%s" % data['lag'])
    tf.eval("/set displayLag=Lag:%s" % data['lag'])
    tf.eval("/set tnl=%s" % data['tnl'])
    tf.eval('/set displayTNL=%s' % data['tnl'])

def Char_Group_List(world, groupies):
    tf.eval("/sendlocal groupieclr:")
    for groupie in groupies:
        log_vitals(groupie["name"].lower(), groupie)
    tf.eval("/set grouplist=%s" % ' '.join([groupie["name"].lower() for groupie in groupies]))
    tf.eval("/set groupies=<%s<" % '<'.join([groupie['name'].lower() for groupie in groupies]))

def Room_RemovePlayer(world, j):
    tf.eval("/send-gmcp char.group.list")

def Room_Info(world, j):
    tf.eval("/send-gmcp char.group.list")

def Room_Players(world, players):
    for player in players.values():
        short = re.sub(remove_parens, "", player["fullname"])
        if short in stabs:
            #tf.eval("/echo stab %s with delay of %0.2f" % (player["name"],stabs[short]))
            tf.eval("/chkassa -w%s %s %.2f" % (world, player["name"],stabs[short]))

def Room_AddPlayer(world, players):
    for player in players.values():
        short = re.sub(remove_parens, "", player["fullname"])
        if short in stabs:
            #tf.eval("/echo stab %s with delay of %0.2f" % (player["name"],stabs[short]))
            tf.eval("/chkassa -w%s %s %.2f" % (world, player["name"],stabs[short]))

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
