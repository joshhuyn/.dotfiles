export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="afowler"

plugins=(
    fzf
    kubectl
    helm
    zsh-vi-mode
    terraform
    starship
)

export FZF_BASE=/usr/bin/fzf

source $ZSH/oh-my-zsh.sh

[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

### Environment Variables ###

export GROFF_NO_SGR=1

export EDITOR='nvim'
export MANPAGER='nvim +Man!'

## custom Path ##

[ -d "$HOME/.spicetify" ] && export PATH=$PATH:$HOME/.spicetify
[ -d "$HOME/.local/bin" ] && export PATH=$PATH:$HOME/.local/bin

[ -d "/usr/share/zsh-syntax-highlighting" ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
[ -x "$(command -v thefuck)" ] && eval $(thefuck --alias)


#lazy load sdkman
sdk() {
	if [ -d "$HOME/.sdkman" ]; then
		export SDKMAN_DIR="$HOME/.sdkman"
		[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh";

		sdk
	fi
}
