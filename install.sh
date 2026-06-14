#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

print_banner() {
    echo ''
    echo "           __ __                     "
    echo "   __  __ / // /_ _____ ____   ____  "
    echo "  / / / // // __// ___// __ \ / __ \ "
    echo " / /_/ // // /_ / /   / /_/ // / / / "
    echo " \__,_//_/ \__//_/    \____//_/ /_/  "
    echo "              setup                  "
    echo "                                     "
}

confirm() {
    local prompt=$1
    local answer
    read -r -p "$prompt" answer
    [[ $answer == [yY] || $answer == [yY][eE][sS] ]]
}

detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)  echo "linux" ;;
        *)      echo "unsupported" ;;
    esac
}

backup_file() {
    local file=$1
    if [[ -f "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
        cp "$file" "$backup"
        echo "Backup created: $backup"
    fi
}

install_dependencies() {
    local os=$1
    echo "Installing dependencies (zsh, curl, git)..."

    if [[ "$os" == "macos" ]]; then
        if ! command -v brew &>/dev/null; then
            echo "Error: Homebrew is required on macOS."
            echo "Install it from https://brew.sh then run this script again."
            exit 1
        fi
        brew install zsh curl git
    elif [[ "$os" == "linux" ]]; then
        if command -v apt-get &>/dev/null; then
            sudo apt-get update
            sudo apt-get install -y zsh curl git
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y zsh curl git
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --needed --noconfirm zsh curl git
        else
            echo "Error: unrecognized package manager."
            echo "Install zsh, curl, and git manually, then run this script again."
            exit 1
        fi
    else
        echo "Error: unsupported operating system ($(uname -s))."
        exit 1
    fi
}

install_antigen() {
    if [[ ! -f "$HOME/antigen.zsh" ]]; then
        echo "Downloading Antigen..."
        curl -fsSL git.io/antigen -o "$HOME/antigen.zsh"
    else
        echo "Antigen already present at ~/antigen.zsh"
    fi
}

install_katoolin() {
    if ! command -v apt-get &>/dev/null; then
        echo "Katoolin is only available on Debian/Ubuntu-based distributions."
        return
    fi

    sudo apt-get update
    sudo apt-get install -y python3 git
    sudo add-apt-repository -y universe || true

    local tmp_dir
    tmp_dir=$(mktemp -d)
    git clone https://github.com/LionSec/katoolin.git "$tmp_dir/katoolin"
    sudo mv "$tmp_dir/katoolin/katoolin.py" /usr/bin/katoolin
    sudo chmod +x /usr/bin/katoolin
    rm -rf "$tmp_dir"

    echo "Starting Katoolin (follow the on-screen instructions)..."
    sudo katoolin
}

print_banner

OS=$(detect_os)
if [[ "$OS" == "unsupported" ]]; then
    echo "Error: this script only supports macOS and Linux."
    exit 1
fi

echo "Detected system: $OS"
echo ''

if confirm "Install Ultron and customize your shell (~/.zshrc will be modified)? (Y/N): "; then
    install_dependencies "$OS"

    echo "Setting up ~/.zshrc"
    backup_file "$HOME/.zshrc"
    cp "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"

    if confirm "Install the Powerlevel10k configuration (~/.p10k.zsh)? (Y/N): "; then
        echo "Setting up ~/.p10k.zsh"
        backup_file "$HOME/.p10k.zsh"
        cp "$SCRIPT_DIR/p10k.zsh" "$HOME/.p10k.zsh"
    fi

    install_antigen
else
    if confirm "Install Antigen only (plugin manager)? (Y/N): "; then
        install_dependencies "$OS"
        install_antigen
    fi
fi

if [[ "$OS" == "linux" ]] && confirm "Install Katoolin (Kali Linux tools on Debian/Ubuntu)? (Y/N): "; then
    install_katoolin
fi

echo ''
echo 'INSTALLATION COMPLETE — THANK YOU'
echo ''
echo "Restart your terminal or run: zsh"
echo ''

if command -v zsh &>/dev/null; then
    exec zsh
fi
