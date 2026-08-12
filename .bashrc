#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lAh'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

alias cx='chmod +x $(fzf)'

# Pacman
alias upd='printf "\033[1;34mUpdating Arch packages...\033[0m\n"; yay -NSyu ; printf "\033[1;34mUpdating AUR...\033[0m\n"; yay -aSyu ;printf "\033[1;34mUpdating Hyprpm...\033[0m\n"; hyprpm update ;  printf "\033[1;34mUpdating Flatpaks...\033[0m\n"; flatpak update -y ; printf "\033[1;34mUpdating Snaps...\033[0m\n"; sudo snap refresh ; printf "\033[1;36mAll updates complete!\033[0m\n"'
alias plist='pacman -Qent'
alias pinfo='pacman -Qi'
alias srh='pacman -Ss'
alias ins='sudo pacman -S'
alias rmv='sudo pacman -Rns'

# Apps
alias gimp='flatpak run org.gimp.GIMP'
alias office='onlyoffice-desktopeditors'
alias storage='ncdu'

#force wayland app
# --enable-features=UseOzonePlatform --ozone-platform=wayland

# alias vim="nvim"
export BAT_THEME="ansi"

# Coloured Man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"TwoDark\"'"
export MANROFFOPT='-c'

alias icat="kitten icat"
eval "$(starship init bash)"

# y to call yazi; q to exit to current yazi directory & Q to exit to orignal dir
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# FZF Themes
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

eval "$(zoxide init bash)"

# Created by `pipx` on 2026-06-18 18:11:56
export PATH="$PATH:$HOME/.local/bin"

export SUDO_PROMPT="$(tput setaf 1 bold)Password:$(tput sgr0) "
