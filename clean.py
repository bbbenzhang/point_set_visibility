import json

data = {"points": []}

with open("bunny.txt", 'r') as f:
    lines = f.readlines()
    for line in lines:
        line = line.split(" ")
        x = float(line[1])
        y = float(line[2])
        z = float(line[3])
        point = {"x": x, "y": y, "z": z}
        data["points"].append(point)

with open("bunny.json", 'w') as f:
    json.dump(data, f, indent=4)
    
    
