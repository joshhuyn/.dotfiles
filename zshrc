if [ -d "$HOME/.oh-my-zsh" ]; then
	export ZSH="$HOME/.oh-my-zsh"

	ZSH_THEME="custom-bira"

	plugins=(
		fzf
		zsh-vi-mode
	)

	export FZF_BASE=/usr/bin/fzf

	source $ZSH/oh-my-zsh.sh
else;
	function getKubeConfig {
	  local context=$(kubectl config current-context)

	  if [[ $context == "k3s" ]]; then
		echo "%F{green}[$context]%f"
	  elif [[ $context == "devCluster" ]]; then
		echo "%F{yellow}[$context]%f"
	  elif [[ $context == "prodCluster" ]]; then
		echo "%F{red}[$context]%f"
	  else
		echo $context
	  fi
	}

	function virtualenv_prompt_info(){
	  [[ -n ${VIRTUAL_ENV} ]] || return
	  echo "(${VIRTUAL_ENV:t:gs/%/%%}) "
	}

	export VIRTUAL_ENV_DISABLE_PROMPT=1

	autoload -Uz vcs_info
	precmd() { vcs_info }

	zstyle ':vcs_info:git:*' formats '%b'
	setopt PROMPT_SUBST

	PROMPT='╭─%F{yellow}%M%f $(getKubeConfig) %F{blue}%~%f %F{red}<${vcs_info_msg_0_}> %f
	╰─ $(virtualenv_prompt_info)'
	RPROMPT="%? %F{green}%*%f"
fi

[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

### Environment Variables ###

alias ls="ls --color=auto"
alias k="kubectl"
alias h="helm"

export GROFF_NO_SGR=1

export EDITOR='nvim'
export MANPAGER='nvim +Man!'

## custom Path ##

[ -d "$HOME/.spicetify" ] && export PATH=$PATH:$HOME/.spicetify
[ -d "$HOME/.local/bin" ] && export PATH=$PATH:$HOME/.local/bin

[ -d "/usr/share/zsh-syntax-highlighting" ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
[ -x "$(command -v helm)" ] && source <(helm completion zsh)
[ -x "$(command -v thefuck)" ] && eval $(thefuck --alias)


[ -d "$HOME/.sdkman/candidates/java/current" ] && export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
[ -d "$HOME/.sdkman/candidates/maven/current" ] && alias mvn="$HOME/.sdkman/candidates/maven/current/bin/mvn"

#lazy load sdkman
sdk() {
	if [ -d "$HOME/.sdkman" ]; then
		export SDKMAN_DIR="$HOME/.sdkman"
		[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh";

		sdk
	fi
}
