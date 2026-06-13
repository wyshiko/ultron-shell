# ULTRON Shell

Configuration zsh personnalisée avec thème Powerlevel10k, gestionnaires de plugins (Zinit + Antigen) et alias utiles.

## Fonctionnalités

- **Prompt** : thème [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (config incluse dans `p10k.zsh`)
- **Plugins** :
  - `zsh-autosuggestions` — suggestions de commandes
  - `zsh-completions` — complétions enrichies
  - `zsh-syntax-highlighting` — coloration syntaxique
  - `web-search` (Oh My Zsh) — recherche web depuis le terminal
- **Alias** : `ll`, `python` → `python3`, `clear` avec bannière Ultron
- **Optionnel** : installation de [Katoolin](https://github.com/LionSec/katoolin) sur Debian/Ubuntu

## Prérequis

| Système | Outil requis |
|---------|--------------|
| macOS   | [Homebrew](https://brew.sh) |
| Linux   | `apt`, `dnf` ou `pacman` selon la distribution |

Le script installe automatiquement **zsh**, **curl** et **git** si nécessaire.

## Installation

```bash
git clone https://github.com/wyshiko/ultron-shell.git
cd ultron-shell
chmod +x install.sh
./install.sh
```

Le script vous guide étape par étape :

1. Installation des dépendances et copie de `~/.zshrc` (avec sauvegarde de l'ancien fichier)
2. Installation optionnelle de `~/.p10k.zsh`
3. Téléchargement d'Antigen dans `~/antigen.zsh`
4. Installation optionnelle de Katoolin (Linux Debian/Ubuntu uniquement)

Relancez ensuite votre terminal ou exécutez :

```bash
zsh
```

## Structure du projet

```
ultron-shell/
├── install.sh   # Script d'installation interactif
├── zshrc        # Configuration zsh (copiée vers ~/.zshrc)
├── p10k.zsh     # Configuration Powerlevel10k (copiée vers ~/.p10k.zsh)
├── README.md
└── LICENSE
```

## Personnalisation

- **Prompt** : lancez `p10k configure` ou éditez `~/.p10k.zsh`
- **Plugins** : modifiez la section plugins dans `~/.zshrc` (Zinit et Antigen)
- **Alias** : ajoutez vos alias dans `~/.zshrc` après l'installation

Les fichiers existants `~/.zshrc` et `~/.p10k.zsh` sont sauvegardés automatiquement avec un horodatage avant toute modification.

## Désinstallation

```bash
# Restaurer une sauvegarde
cp ~/.zshrc.backup.XXXXXXXX ~/.zshrc

# Supprimer les fichiers installés (optionnel)
rm -f ~/antigen.zsh ~/.p10k.zsh
```

## Licence

Ce projet est dans le domaine public — voir [LICENSE](LICENSE).
