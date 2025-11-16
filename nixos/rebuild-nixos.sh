#!/usr/bin/env bash

# Flag default values
interactive_mode=false
flake_path="$HOME/.dotfiles/nixos/"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color / reset

show_help() {
    local exit_status=${1:-0}
    echo -e "${BLUE}NixOS Rebuild Script Options:${NC}"
    echo -e "  -i, --interactive       Ask for confirmation and additional options"
    echo -e "  -f, --flake-path PATH   Specify the path to your flake.nix file (default: $HOME/.dotfiles/nixos/)"
    echo -e "  -h, --help              Show this help message and exit"
    exit "$exit_status"
}

PARSED_ARGS=$(getopt -o f:ih --long flake-path:interactive,help -- "$@") || {
    echo -e "${RED}Error: Failed to parse arguments${NC}" >&2
    show_help 1
}
eval set -- "$PARSED_ARGS"

while true; do
    case "$1" in
        -i|--interactive) interactive_mode=true; shift ;;
        -f|--flake-path) flake_path="$2"; shift 2 ;;
        -h|--help) show_help ;;
        --) shift; break ;;
        *) echo -e "${RED}Error: Unexpected option: $1${NC}"; show_help 1 ;;
    esac
done

echo -e "${BLUE}Starting NixOS Rebuild Script...${NC}"

# cd to where your flake.nix file is located
pushd "$flake_path" >/dev/null || { echo -e "${RED}Error: Failed to cd to $flake_path${NC}"; exit 1; }

# Skip question if -y flag is set
if [ "$interactive_mode" = false ]; then
    update_lock="Y"
else
    read -p "Do you want to update the flake.lock file? [Y/n]: " update_lock
    update_lock=${update_lock:-Y} # Default to yes
fi

if [[ "$update_lock" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Updating flake.lock file...${NC}"
    # nix flake update --recreate-lock-file --commit-lock-file
    nix flake update
else
    echo -e "${YELLOW}Using existing flake.lock file...${NC}"
fi

if [ "$interactive_mode" = false ]; then
    target_host=$(hostname)
    show_progress="N"
else
    read -p "Which host do you want to rebuild as? [Default: $(hostname)]: " target_host
    target_host=${target_host:-$(hostname)} # Default to current hostname

    read -p "Do you want to see rebuild progress? [y/N]: " show_progress
    show_progress=${show_progress:-N} # Default to no
fi

echo -e "${BLUE}Rebuilding NixOS for host: \"$target_host\"...${NC}"

if [[ "$show_progress" =~ ^[Yy]$ ]]; then
    sudo nixos-rebuild switch --flake '.#' 2>&1 | tee rebuild.log
else
    sudo nixos-rebuild switch --flake '.#' &>rebuild.log
fi

status=${PIPESTATUS[0]}
if [ $status -ne 0 ]; then
    bat --plain --paging=never rebuild.log
    exit "$status"
fi

# Notify all OK!
echo -e "${GREEN}NixOS rebuild complete!${NC}"
# notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
dunstify "NixOS rebuild complete!" --appname="NixOS" --icon=software-update-available

# Ask if the user wants to clean up old generations
if [ "$interactive_mode" = false ]; then
    cleanup="Y"
else
    read -p "Do you want to delete generations older than 14 days? [Y/n]: " cleanup
    cleanup=${cleanup:-Y} # Default to yes
fi

if [[ "$cleanup" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Deleting generations older than 14 days...${NC}"
    if [[ "$show_progress" =~ ^[Yy]$ ]]; then
        sudo nix-collect-garbage --delete-older-than 14d
    else
        sudo nix-collect-garbage --delete-older-than 14d &>/dev/null
    fi

    echo -e "${GREEN}Garbage collection complete!${NC}"
else
    echo -e "${YELLOW}Skipping garbage collection.${NC}"
fi

echo -e "${GREEN}All done!${NC}"

# Back to where you were
popd >/dev/null

exit 0
