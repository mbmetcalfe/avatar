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


def send_vitals(world, groupie):
    tf.eval("/sendlocal groupie:{}|{}|{}|{}|{}|{}".format(
        world,
        groupie["hp"],
        groupie["maxhp"],
        groupie["mp"],
        groupie["maxmp"],
        groupie.get("position", "**")))

def Char_Status(world, status):
    area = status.get('area_name', None)
    if area:
        area_match = re.match(r'^\{[^\}]+\}\s+[^\s]*\s+(.*)', area)
        if area_match:
            area = area_match.groups()[0]
        tf.eval("/echo -p @{hCyellow}In %s" % area)
        if area not in area_ignore:
            ammo_type = ammo_area.get(area, "piercing")
            tf.eval("/ammo_swap -w%s %s" % (world, ammo_type))

def Char_Vitals(world, groupie):
    send_vitals(world, groupie)
    #tf.eval("/send-gmcp char.group.list")

def Char_Group_List(world, groupies):
    tf.eval("/sendlocal groupieclr:")
    for groupie in groupies:
        send_vitals(groupie["name"].lower(), groupie)
    tf.eval("/set grouplist=%s" % ' '.join([groupie["name"].lower() for groupie in groupies]))

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
