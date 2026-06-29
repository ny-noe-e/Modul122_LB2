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

main() {
    WRITE_FILE=false

    check_arguments "$@"

    printf "%s\n" "$SCRIPT_NAME"
    printf "Version: %s\n" "$SCRIPT_VERSION"
    printf "Dateiausgabe aktiv: %s\n" "$WRITE_FILE"
}

main "$@"
