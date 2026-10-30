#!/bin/bash
# System report for Kim Vladislav.
# Usage: ./scripts/Kim_Vladislav_system_report.sh [log_file]

STUDENT_NAME="Kim Vladislav"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="${1:-$SCRIPT_DIR/../logs/Kim_Vladislav_system_report.log}"

section() {
    echo
    echo "=== $1 ==="
}

report() {
    echo "########## SYSTEM REPORT ##########"
    echo "Student:   $STUDENT_NAME"
    echo "Date/time: $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo "Username:  $(whoami)"

    section "Operating system and kernel"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "OS:     $PRETTY_NAME"
    elif command -v sw_vers >/dev/null 2>&1; then
        echo "OS:     $(sw_vers -productName) $(sw_vers -productVersion)"
    fi
    echo "Kernel: $(uname -s) $(uname -r) ($(uname -m))"

    section "CPU"
    if command -v lscpu >/dev/null 2>&1; then
        lscpu | grep -E 'Model name|^CPU\(s\)|Architecture'
    else
        echo "Model name: $(sysctl -n machdep.cpu.brand_string)"
        echo "CPU(s):     $(sysctl -n hw.ncpu)"
    fi

    section "Memory"
    if command -v free >/dev/null 2>&1; then
        free -h
    else
        echo "Total memory: $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) GB"
        vm_stat | head -5
    fi

    section "Disk usage"
    df -h

    section "Available disk space on /"
    df -h / | awk 'NR==2 {print "Available: " $4 " of " $2 " (" $5 " used)"}'
    echo "###################################"
}

# tee prints to the terminal and appends to the log at the same time
report | tee -a "$LOG_FILE"
