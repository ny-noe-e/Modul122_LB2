#!/bin/bash

SCRIPT_NAME="Systemleistung Monitor"
SCRIPT_VERSION="1.0"

# TBZ-M122: Zeigt die korrekte Verwendung des Skripts an.
print_usage() {
    printf "Verwendung:\n"
    printf "  ./systemleistung.sh\n"
    printf "  ./systemleistung.sh -h\n"
}

# TBZ-M122: Startpunkt des Skripts.
main() {
    printf "%s\n" "$SCRIPT_NAME"
    printf "Version: %s\n" "$SCRIPT_VERSION"
    printf "\n"
    print_usage
}

main "$@"
