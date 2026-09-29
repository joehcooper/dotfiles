# ~joehcooper

My personal dotfiles and shared configurations. Includes a one-step bootstrap script to provision new machines and sync environments across multiple operating systems easily.

## Compatibility

The bootstrap script automatically detects the environment and installs the corresponding package manager. 

| Operating System | Package Manager | Notes |
| :--- | :--- | :--- |
| macOS *(darwin)* | Homebrew | Apple Silicon (M-Series / ARM) only |

## Getting Started

### 1. Run the bootstrap script.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/joehcooper/dotfiles/main/bootstrap.sh)"
```

This does the following things:

1. Installs my prefererred package manager for the current OS.
2. Installs `chezmoi` with the newly installed package manager.
3. Clones this repo onto the machine and applies the dotfiles using `chezmoi apply`.

## Usage

See [chezmoi.io](https://www.chezmoi.io/) for usage instructions.

