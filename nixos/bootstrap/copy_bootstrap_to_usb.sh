#!/usr/bin/env bash

# Exit on error
set -e

default_dotfiles_path="$HOME/.dotfiles/"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color / reset

read -p "Where are your dotfiles located? [Default: $default_dotfiles_path]: " dotfiles_path
dotfiles_path=${dotfiles_path:-$default_dotfiles_path}

read -p "Where do you want to copy the bootstrap files? [Default: $(pwd)]: " target_path
target_path=${target_path:-$(pwd)}

echo -e "${BLUE}Copying bootstrap files to $target_path...${NC}"
mkdir -p $target_path/bash
# mkdir -p $target_path/git
# mkdir -p $target_path/gpg
mkdir -p $target_path/nixos
cp $dotfiles_path/bash/.bashrc $target_path/bash/
cp $dotfiles_path/zsh/.aliases $target_path/bash/
# cp $dotfiles_path/git/.gitconfig $target_path/git/
# cp $dotfiles_path/git/allowed_signers $target_path/git/
# cp $dotfiles_path/gpg/sshcontrol $target_path/gpg/
cp $dotfiles_path/nixos/bootstrap/bootstrap.nix $target_path/nixos/
cp $dotfiles_path/nixos/bootstrap/copy_bootstrap_to_host.sh $target_path/
echo -e "${GREEN}Done!${NC}"
