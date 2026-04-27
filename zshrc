export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="afowler"

plugins=(
    fzf
    git
    chucknorris
    kubectl
    helm
    zsh-vi-mode
    nix-zsh-completions
    terraform
    starship
)

source $ZSH/oh-my-zsh.sh


export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


export EDITOR='nvim'
export MANPAGER='nvim +Man!'


[ -d "$HOME/.spicetify" ] && export PATH=$PATH:$HOME/.spicetify
[ -d "$HOME/.local/bin" ] && export PATH=$PATH:$HOME/.local/bin

[ -d "/usr/share/zsh-syntax-highlighting" ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
[ -x "$(command -v thefuck)" ] && eval $(thefuck --alias)

[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [ -d "$HOME/.sdkman" ]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
