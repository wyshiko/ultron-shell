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
        echo "Sauvegarde créée : $backup"
    fi
}

install_dependencies() {
    local os=$1
    echo "Installation des dépendances (zsh, curl, git)..."

    if [[ "$os" == "macos" ]]; then
        if ! command -v brew &>/dev/null; then
            echo "Erreur : Homebrew est requis sur macOS."
            echo "Installez-le depuis https://brew.sh puis relancez ce script."
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
            echo "Erreur : gestionnaire de paquets non reconnu."
            echo "Installez manuellement zsh, curl et git, puis relancez ce script."
            exit 1
        fi
    else
        echo "Erreur : système d'exploitation non supporté ($(uname -s))."
        exit 1
    fi
}

install_antigen() {
    if [[ ! -f "$HOME/antigen.zsh" ]]; then
        echo "Téléchargement d'Antigen..."
        curl -fsSL git.io/antigen -o "$HOME/antigen.zsh"
    else
        echo "Antigen déjà présent dans ~/antigen.zsh"
    fi
}

install_katoolin() {
    if ! command -v apt-get &>/dev/null; then
        echo "Katoolin n'est disponible que sur les distributions basées sur Debian/Ubuntu."
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

    echo "Lancement de Katoolin (suivez les instructions à l'écran)..."
    sudo katoolin
}

print_banner

OS=$(detect_os)
if [[ "$OS" == "unsupported" ]]; then
    echo "Erreur : ce script supporte uniquement macOS et Linux."
    exit 1
fi

echo "Système détecté : $OS"
echo ''

if confirm "Installer Ultron et personnaliser votre shell (~/.zshrc sera modifié) ? (Y/N): "; then
    install_dependencies "$OS"

    echo "Initialisation de ~/.zshrc"
    backup_file "$HOME/.zshrc"
    cp "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"

    if confirm "Installer la configuration Powerlevel10k (~/.p10k.zsh) ? (Y/N): "; then
        echo "Initialisation de ~/.p10k.zsh"
        backup_file "$HOME/.p10k.zsh"
        cp "$SCRIPT_DIR/p10k.zsh" "$HOME/.p10k.zsh"
    fi

    install_antigen
else
    if confirm "Installer uniquement Antigen (gestionnaire de plugins) ? (Y/N): "; then
        install_dependencies "$OS"
        install_antigen
    fi
fi

if [[ "$OS" == "linux" ]] && confirm "Installer Katoolin (outils Kali Linux sur Debian/Ubuntu) ? (Y/N): "; then
    install_katoolin
fi

echo ''
echo 'INSTALLATION TERMINÉE — MERCI'
echo ''
echo "Relancez votre terminal ou exécutez : zsh"
echo ''

if command -v zsh &>/dev/null; then
    exec zsh
fi
