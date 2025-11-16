#!/usr/bin/env bash

# Exit on error
set -e

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color / reset

echo -e "${BLUE}Copying bootstrap files to host...${NC}"
# mkdir -p ~/.config/git
# mkdir -p ~/.ssh
cp ./bash/.bashrc ~/.bashrc
cp ./bash/.aliases ~/.aliases
# cp ./git/.gitconfig ~/.gitconfig
# cp ./git/allowed_signers ~/.config/git/allowed_signers
# cp ./gpg/sshcontrol ~/.gnupg/sshcontrol
echo -e "${BLUE}Requesting sudo permission for copying bootstrap.nix to /etc/nixos${NC}"
sudo cp ./nixos/bootstrap.nix /etc/nixos/bootstrap.nix
echo -e "${GREEN}Done!${NC}"
