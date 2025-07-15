#!/sbin/python
import subprocess

p = subprocess.check_output(['hyprctl', 'clients'])
output = str(p).replace("\\t", "").split("\\n")

windows = []

currentObj = {}
for line in output:
    if line.startswith("Window"):
        print(line)
    elif line.startswith("class:"):
        print(line)
    elif line.startswith("pid:"):
        print(line)
