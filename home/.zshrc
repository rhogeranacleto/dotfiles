# Created by newuser for 5.7.1
ZSH="/usr/share/oh-my-zsh/"
ZSH_CUSTOM="$HOME/.config/zsh/"
# ZSH_THEME="kolo"
DISABLE_AUTO_UPDATE="false"

plugins=(
  git
  z
  cp
  sudo
  fancy-ctrl-z
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
fi

[[ -f "$ZSH/oh-my-zsh.sh" ]] &&
    source $ZSH/oh-my-zsh.sh

[[ -f "$HOME/.zprofile" ]] &&
    source $HOME/.zprofile

[[ -f "$HOME/.zshenv" ]] &&
    source $HOME/.zshenv

[[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

[[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -f "/usr/share/nvm/init-nvm.sh" ]] &&
	source /usr/share/nvm/init-nvm.sh

# auto loading node version if has .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

bindkey '^H' backward-kill-word

eval "$(starship init zsh)"