#!/usr/bin/env python3
# NOTE: THIS IS PURELY AI CODED AND NOT MANUALLY CHECKED (ALTHOUGH THE CODE APPEARS TO WORK)
"""Stream one Waybar update per second using interval CPU accounting."""

import html
import json
import time
from pathlib import Path

PROGRAM_NAME_WIDTH = 20


def snapshot():
    cpus = {}
    for line in Path("/proc/stat").read_text().splitlines():
        fields = line.split()
        if not fields or not fields[0].startswith("cpu"):
            continue
        # Guest time is already included in user/nice; do not count it twice.
        ticks = list(map(int, fields[1:9]))
        cpus[fields[0]] = (sum(ticks), ticks[3] + ticks[4])

    processes = {}
    for path in Path("/proc").glob("[0-9]*/stat"):
        try:
            stat = path.read_text()
            # comm may contain spaces or parentheses. Fields after its final
            # closing parenthesis start at field 3 (state).
            end = stat.rindex(")")
            name = stat[stat.index("(") + 1 : end]
            fields = stat[end + 2 :].split()
            # Include starttime in the key to handle PID reuse.
            key = (path.parent.name, int(fields[19]))
            processes[key] = (name, int(fields[11]) + int(fields[12]))
        except (OSError, ValueError, IndexError):
            # Processes can exit or become inaccessible during a snapshot.
            continue
    return cpus, processes


def usage(current, previous):
    total = current[0] - previous[0]
    idle = current[1] - previous[1]
    return max(0, min(100, 100 * (total - idle) / total)) if total > 0 else 0


def core_grid(cpus, previous):
    cores = sorted((key for key in cpus if key != "cpu"), key=lambda key: int(key[3:]))
    if not cores:
        return "Unavailable"
    columns = min(4, len(cores))
    cells = [
        f"{usage(cpus[key], previous[key]):3.0f}%" if key in previous else "   —"
        for key in cores
    ]
    border = "+" + "+".join(["------"] * columns) + "+"
    rows = [border]
    for start in range(0, len(cells), columns):
        row = cells[start : start + columns]
        row += ["    "] * (columns - len(row))
        rows.append("|" + "|".join(f" {cell} " for cell in row) + "|")
        rows.append(border)
    return "\n".join(rows)


def status(current, previous):
    cpus, processes = current
    old_cpus, old_processes = previous
    percentage = round(usage(cpus["cpu"], old_cpus["cpu"]))
    total = cpus["cpu"][0] - old_cpus["cpu"][0]
    programs = {}
    for key, (name, ticks) in processes.items():
        # New processes started within this interval, so all their CPU time
        # belongs to it. A matching starttime guards against reused PIDs.
        old_ticks = old_processes.get(key, (name, 0))[1]
        name = " ".join(name.split())
        programs[name] = programs.get(name, 0) + max(0, ticks - old_ticks)

    tooltip = f"{percentage}% total CPU usage\n\n"
    tooltip += "Logical cores (CPU ID order, left to right):\n<tt>"
    tooltip += core_grid(cpus, old_cpus) + "</tt>"
    top = sorted(programs.items(), key=lambda item: (-item[1], item[0]))[:10]
    if top:
        width = PROGRAM_NAME_WIDTH + 1  # Include the trailing colon.
        rows = []
        for name, ticks in top:
            percent = 100 * ticks / total if total > 0 else 0
            if len(name) > PROGRAM_NAME_WIDTH:
                name = name[: PROGRAM_NAME_WIDTH - 1] + "…"
            rows.append(html.escape(f"{name + ':':<{width}} {percent:5.1f} %"))
        tooltip += "\n\nTop programs (% of total CPU):\n<tt>"
        tooltip += "\n".join(rows) + "</tt>"
    return {"text": str(percentage), "percentage": percentage, "tooltip": tooltip}


def main():
    previous = snapshot()
    while True:
        time.sleep(1)
        current = snapshot()
        print(json.dumps(status(current, previous)), flush=True)
        previous = current


if __name__ == "__main__":
    try:
        main()
    except BrokenPipeError:
        pass
