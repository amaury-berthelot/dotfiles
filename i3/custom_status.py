#!/usr/bin/env python

import sys
import json
import subprocess

if __name__ == "__main__":
    sys.stdout.write(sys.stdin.readline() + "\n")
    sys.stdout.flush()
    sys.stdout.write(sys.stdin.readline() + "\n")
    sys.stdout.flush()

    while True:
        line = sys.stdin.readline()
        prefix = ""

        if line.startswith(","):
            line = line[1:]
            prefix = ","

        info = json.loads(line)

        swap_res = subprocess.check_output(["bash", "-c", "free | grep 'Swap'"]).decode("utf-8").split()
        swap_percent = int((int(swap_res[2]) / int(swap_res[1])) * 100)
        info.insert(len(info) - 1, { "full_text": "Swap: " + str(swap_percent) + "%" })

        sys.stdout.write(prefix + json.dumps(info) + "\n")
        sys.stdout.flush()
