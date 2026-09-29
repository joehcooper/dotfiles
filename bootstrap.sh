#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Detect the Operating System
OS="$(uname -s)"
case "${OS}" in
    Darwin*)    OS_TYPE="darwin" ;;
    Linux*)     OS_TYPE="linux" ;;
    CYGWIN*|MINGW*|MSYS*) OS_TYPE="windows" ;;
    *)          OS_TYPE="unknown" ;;
esac

echo "Detected OS: $OS_TYPE"

# 2. Exit if not macOS 
if [ "$OS_TYPE" != "darwin" ]; then
    echo "Aborting: Currently only macOS is supported by this bootstrap script."
    exit 1
fi

# 3. Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Temporarily add brew to path (Apple Silicon)
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

# 4. Install chezmoi
if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi via Homebrew..."
    brew install chezmoi
else
    echo "chezmoi is already installed."
fi

# 5. Initialize and apply dotfiles safely
CHEZMOI_DIR="$HOME/.local/share/chezmoi"

if [ -d "$CHEZMOI_DIR/.git" ]; then
    echo "====================================================="
    echo "Chezmoi is already initialized on this machine."
    echo "To view unsaved changes safely, run:  chezmoi diff"
    echo "To pull the latest changes, run:      chezmoi update"
    echo "====================================================="
    exit 0
else
    echo "Initializing chezmoi for the first time..."
    # Since we enforce macOS and install via brew, chezmoi is guaranteed to be in $PATH
    chezmoi init --apply joehcooper 
fi

echo "Bootstrap complete!"
