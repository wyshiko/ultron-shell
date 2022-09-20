### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###Add Antigen 

if [[ ! -f ~/antigen.zsh ]]; then
        curl -L git.io/antigen > ~/antigen.zsh
fi

echo "  ▄     ▄▄▄▄▀ █▄▄▄▄ ████▄    ▄   ";
echo "   █ ▀▀▀ █    █  ▄▀ █   █     █  ";
echo "█   █    █    █▀▀▌  █   █ ██   █ ";
echo "█   █   █     █  █  ▀████ █ █  █ ";
echo "█▄ ▄█  ▀        █         █  █ █ ";
echo " ▀▀▀           ▀          █   ██ ";
echo "                                 ";

#==  PROMPT   ===========================================
# Prompt custom
PROMPT='%S%F{white} %n@%m ❯%f%s %F{cyan}%1~%f %# '

#==  PLUGUIN   ===========================================

#Managers sources

source ~/antigen.zsh

#Call plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit snippet OMZP::sudo

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
antigen theme romkatv/powerlevel10k
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle web-search
#antigen apply
antigen apply

#==  CUSTOM ZSH   ========================================
# Change color for directory
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
alias ll="ls -alG"

# Basi auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

#Call python3 when typing python
alias python='python3'
alias clear='clear;

echo "  ▄     ▄▄▄▄▀ █▄▄▄▄ ████▄    ▄   ";
echo "   █ ▀▀▀ █    █  ▄▀ █   █     █  ";
echo "█   █    █    █▀▀▌  █   █ ██   █ ";
echo "█   █   █     █  █  ▀████ █ █  █ ";
echo "█▄ ▄█  ▀        █         █  █ █ ";
echo " ▀▀▀           ▀          █   ██ ";
echo "                                 ";

'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh