# ULTRON Shell

Custom zsh configuration with Powerlevel10k theme, plugin managers (Zinit + Antigen), and useful aliases.

## Features

- **Prompt**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme (config included in `p10k.zsh`)
- **Plugins**:
  - `zsh-autosuggestions` — command suggestions
  - `zsh-completions` — enhanced completions
  - `zsh-syntax-highlighting` — syntax highlighting
  - `web-search` (Oh My Zsh) — web search from the terminal
- **Aliases**: `ll`, `python` → `python3`, `clear` with Ultron banner
- **Optional**: [Katoolin](https://github.com/LionSec/katoolin) installation on Debian/Ubuntu

## Prerequisites

| System | Required tool |
|--------|---------------|
| macOS  | [Homebrew](https://brew.sh) |
| Linux  | `apt`, `dnf`, or `pacman` depending on your distribution |

The install script automatically installs **zsh**, **curl**, and **git** if needed.

## Installation

```bash
git clone https://github.com/wyshiko/ultron-shell.git
cd ultron-shell
chmod +x install.sh
./install.sh
```

The script walks you through each step:

1. Install dependencies and copy `~/.zshrc` (with backup of the existing file)
2. Optional installation of `~/.p10k.zsh`
3. Download Antigen to `~/antigen.zsh`
4. Optional Katoolin installation (Debian/Ubuntu Linux only)

Then restart your terminal or run:

```bash
zsh
```

## Project structure

```
ultron-shell/
├── install.sh   # Interactive install script
├── zshrc        # zsh configuration (copied to ~/.zshrc)
├── p10k.zsh     # Powerlevel10k configuration (copied to ~/.p10k.zsh)
├── README.md
└── LICENSE
```

## Customization

- **Prompt**: run `p10k configure` or edit `~/.p10k.zsh`
- **Plugins**: edit the plugins section in `~/.zshrc` (Zinit and Antigen)
- **Aliases**: add your aliases to `~/.zshrc` after installation

Existing `~/.zshrc` and `~/.p10k.zsh` files are automatically backed up with a timestamp before any changes.

## Uninstall

```bash
# Restore a backup
cp ~/.zshrc.backup.XXXXXXXX ~/.zshrc

# Remove installed files (optional)
rm -f ~/antigen.zsh ~/.p10k.zsh
```

## License

This project is in the public domain — see [LICENSE](LICENSE).
