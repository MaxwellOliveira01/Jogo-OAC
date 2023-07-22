import os

def readSprite(file_path):

    '''
    file needs to be in the following way:

    map: .word 
    640, 240
    .byte 
    ......data......
    '''

    data = []
    with open(file_path) as f:
        f.readline(); #ignoring name and .word
        [w, h] = [int(i) for i in f.readline().split(',')]
        f.readline(); # ignore ".byte"
        for _ in range(h):
            line = f.readline().split(',')
            line.pop() # ignoring \n
            data.append([int(i) for i in line])
    assert(w == len(data[0]))
    assert(h == len(data))
    return data


def writeOutput(file_path, sprite_name, data):
    with open(file_path, 'w') as f:
        f.write(sprite_name + ": .word\n")
        w = len(data[0])
        h = len(data)
        f.write(str(w) + ", " + str(h) + "\n")
        f.write(".byte\n")

        for i in range(h):
            line = ",".join([str(k) for k in data[i]]) + ",\n"
            f.write(line)

    return

# Read map

map = readSprite('map.s')
#print(len(map[0]), len(map))

# Read all walls type

walls = []

with os.scandir('walls/') as it:
    for entry in it:
        if entry.name.endswith('.data') and entry.is_file():
            walls.append(readSprite(entry.path))
            #print(len(walls[-1][0]), len(walls[-1]))

#print(len(walls))

tamTile = 16

assert(len(map) % tamTile == 0)
assert(len(map[0]) % tamTile == 0)

for i in range(0, len(map), tamTile):
    for j in range(0, len(map[0]), tamTile):
        
        cur_sprite = []
        
        for k in range(tamTile):   
            cur_sprite.append(map[i + k][j : j + tamTile])

        isWall = False

        for w in walls:
            if w == cur_sprite:
                isWall = True

        if isWall:
            
            # if is a wall change the cur_sprite on map to 0

            for k in range(tamTile):
                map[i + k][j : j + tamTile] = [0] * tamTile

        else:

            # if is not a wall, change the cur_sprite to white color

            for k in range(tamTile):
                map[i + k][j : j + tamTile] = [255] * tamTile



writeOutput("./output/mapHitBox.data", "mapHitBox", map)



