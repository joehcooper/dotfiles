#!/bin/bash

set -eufo pipefail

# XDG_DATA_HOME for the framework
OMZ_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"

if [ ! -d "$OMZ_DIR" ]; then
  echo "Installing Oh My Zsh to $OMZ_DIR..."
  
  env ZSH="$OMZ_DIR" KEEP_ZSHRC=yes RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
  echo "Oh My Zsh installed successfully!"
else
  echo "Oh My Zsh is already installed at $OMZ_DIR. Skipping."
fi
