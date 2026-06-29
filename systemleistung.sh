#!/bin/bash

SCRIPT_NAME="Systemleistung Monitor"
SCRIPT_VERSION="1.0"

print_usage() {
    printf "Verwendung:\n"
    printf "  ./systemleistung.sh        Ausgabe nur im Terminal\n"
    printf "  ./systemleistung.sh -f     Ausgabe im Terminal und zusätzlich in eine Logdatei\n"
    printf "  ./systemleistung.sh -h     Hilfe anzeigen\n"
}

check_arguments() {
    if [ "$#" -gt 1 ]; then
        printf "Fehler: Zu viele Argumente.\n"
        print_usage
        exit 1
    fi

    if [ "$#" -eq 1 ]; then
        case "$1" in
            -f)
                WRITE_FILE=true
                ;;
            -h|--help)
                print_usage
                exit 0
                ;;
            *)
                printf "Fehler: Unbekannter Parameter '%s'.\n" "$1"
                print_usage
                exit 1
                ;;
        esac
    fi
}


check_commands() {
    REQUIRED_COMMANDS=("date" "uname" "uptime" "awk" "grep" "sed" "cat")

    for CMD in "${REQUIRED_COMMANDS[@]}"; do
        if ! command -v "$CMD" >/dev/null 2>&1; then
            printf "Fehler: Der Befehl '%s' wurde nicht gefunden.\n" "$CMD"
            exit 1
        fi
    done
}


get_system_time() {
    date '+%Y-%m-%d %H:%M:%S'
}


get_system_uptime() {
    uptime -p 2>/dev/null | sed 's/up //'
}


get_hostname_value() {
    if [ -f /proc/sys/kernel/hostname ]; then
        cat /proc/sys/kernel/hostname
    else
        uname -n
    fi
}


get_os_name() {
    if [ -f /etc/os-release ]; then
        grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"'
    else
        uname -s
    fi
}

main() {
    WRITE_FILE=false

    check_arguments "$@"
    check_commands

    printf "Systemzeit: %s\n" "$(get_system_time)"
    printf "Systemlaufzeit: %s\n" "$(get_system_uptime)"
    printf "Hostname: %s\n" "$(get_hostname_value)"
    printf "Betriebssystem: %s\n" "$(get_os_name)"
}

main "$@"
