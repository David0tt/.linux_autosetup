#!/bin/sh
# Sum resident memory by ps command name. Shared pages count in each process,
# so program RSS totals are not additive with the system used-memory total.
export LC_ALL=C

ps -e -o rss= -o comm= | awk '
function json_string(value,    result, i, char) {
    result = "\""
    for (i = 1; i <= length(value); i++) {
        char = substr(value, i, 1)
        if (char == "\\" || char == "\"") result = result "\\" char
        else if (char == "\n") result = result "\\n"
        else if (char == "\t") result = result "\\t"
        else if (char == "\r") result = result "\\r"
        else if (char ~ /[[:cntrl:]]/) result = result "?"
        else result = result char
    }
    return result "\""
}
function markup(value) {
    gsub(/&/, "\\&amp;", value)
    gsub(/</, "\\&lt;", value)
    gsub(/>/, "\\&gt;", value)
    return value
}
FILENAME == "/proc/meminfo" {
    if ($1 == "MemTotal:") total = $2
    if ($1 == "MemAvailable:") available = $2
    next
}
$1 > 0 {
    rss = $1
    sub(/^[[:space:]]*[0-9]+[[:space:]]+/, "")
    gsub(/[[:space:]]+/, " ")
    programs[$0] += rss
}
END {
    if (total <= 0) {
        print "{\"text\":\"?\",\"tooltip\":\"Memory information unavailable\"}"
        exit
    }
    used = total - available
    percentage = int(100 * used / total)
    tooltip = sprintf("%.1f GiB of %.1f GiB used", used / 1048576, total / 1048576)

    # Select only the ten largest groups; no extra sort process is needed.
    for (i = 1; i <= 10; i++) {
        best = ""
        for (name in programs)
            if (best == "" || programs[name] > programs[best] ||
                (programs[name] == programs[best] && name < best)) best = name
        if (best == "") break
        count++
        names[i] = best ":"
        gib[i] = sprintf("%.2f", programs[best] / 1048576)
        percent[i] = sprintf("%.1f", 100 * programs[best] / total)
        if (length(names[i]) > name_width) name_width = length(names[i])
        if (length(gib[i]) > gib_width) gib_width = length(gib[i])
        if (length(percent[i]) > percent_width) percent_width = length(percent[i])
        delete programs[best]
    }
    if (count) {
        tooltip = tooltip "\n\nTop programs (RSS):\n<tt>"
        for (i = 1; i <= count; i++) {
            row = sprintf("%-*s %*s GiB | %*s %%", name_width, names[i],
                          gib_width, gib[i], percent_width, percent[i])
            tooltip = tooltip (i > 1 ? "\n" : "") markup(row)
        }
        tooltip = tooltip "</tt>"
    }
    printf "{\"text\":\"%d\",\"percentage\":%d,\"tooltip\":%s}\n", \
           percentage, percentage, json_string(tooltip)
}' /proc/meminfo -
