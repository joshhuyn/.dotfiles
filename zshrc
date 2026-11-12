# [ -z "$TMUX"  ] && [ "$JOH_ENABLE_TMUX" = "true" ] && { tmux attach || exec tmux new-session && exit;}
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

if [ -d "$HOME/.oh-my-zsh" ]; then
	export ZSH="$HOME/.oh-my-zsh"

	ZSH_THEME="custom-bira"

    plugins=()

	# plugins=(
	# 	fzf
	# 	zsh-vi-mode
	# )

	export FZF_BASE=/usr/bin/fzf

	source $ZSH/oh-my-zsh.sh
    # rm -f ~/.zcompdump* ~/.oh-my-zsh/cache/.zcompdump*

    # source $HOME/common/zsh-autocomplete/zsh-autocomplete.plugin.zsh

    precmd()
    {
        omz theme use $ZSH_THEME
    }
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

    autoload -Uz compinit
    compinit

    zstyle ':vcs_info:git:*' formats '%b'
    setopt PROMPT_SUBST

    # PROMPT='╭─%F{yellow}%M%f $(getKubeConfig) %F{blue}%~%f %F{red}<${vcs_info_msg_0_}> %f
    # ╰─ $(virtualenv_prompt_info)'
    # RPROMPT="%? %F{green}%*%f"

    PROMPT='╭─%F{yellow}%M%f $(getKubeConfig) %F{blue}%~%f %F{red}<${vcs_info_msg_0_}> %f
╰─ $(virtualenv_prompt_info)'
    RPROMPT="%? %F{green}%*%f"
fi

alias ls="ls --color=auto"
alias k="kubectl"
alias h="helm"

### Environment Variables ###

export GROFF_NO_SGR=1

export EDITOR='nvim'
# export MANPAGER='nvim +Man!'

## custom Path ##

[ -d "$HOME/.spicetify" ] && export PATH=$PATH:$HOME/.spicetify
[ -d "$HOME/.local/bin" ] && export PATH=$PATH:$HOME/.local/bin

[ -d "/usr/local/go" ] && export PATH=$PATH:/usr/local/go/bin
[ -d "$HOME/go" ] && export PATH=$PATH:$HOME/go/bin

[ -d "$HOME/.local/share/gem/ruby/3.3.0/bin" ] && export PATH=$PATH:$HOME/.local/share/gem/ruby/3.3.0/bin

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


proxy_claude() {
    if [[ ! -d ./.git ]]; then
        echo "not a git project!"
        return
    fi

    allowed_remotes=(
        "git@gitlab.ivfp.de:ivfp/Atlas.git" 
        "git@gitlab.ivfp.de:ivfp/Fairgleichen.git"
    )

    current_remote=$(git remote get-url origin)

    if printf '%s\0' "${allowed_remotes[@]}" | grep -Fxz "${current_remote}" >/dev/null;
    then
        claude
    else
        echo "remote ${remote} is not allowed!"
    fi
}

alias mycli-atlas="mycli -u root Atlas -p"
alias mycli-fg="mycli -u root Fairgleichen -p"
alias mycli-axa="mycli -u root axa-fondsnavigator -p"

# peon-ping quick controls
alias peon="bash /home/huynh/.claude/hooks/peon-ping/peon.sh"
[ -f /home/huynh/.claude/hooks/peon-ping/completions.bash ] && source /home/huynh/.claude/hooks/peon-ping/completions.bash

echo "TODO: Fairgleichen qa auf keycloak dev umstellen"

echo ""

echo "TODO: openwebui und openterminal updaten"
echo "TODO: k8s-log-viewer fertig deployen"
echo "TODO: atlas fonds rating testen"
echo "TODO: nginx qa ip filter"
echo "TODO: look at ~/dev/repos/performance-optimierungen.md"


function claude-tmp()
{
    echo -n "creating temp dir: "
    mkdir /tmp/josh-claude-tmp/ 1> /dev/null 2> /dev/null
    cd /tmp/josh-claude-tmp/
    echo "$?"

    if [ $? = 0 ]; then
        claude
    fi

    echo -n "removing temp dir: "
    rmdir /tmp/josh-claude-tmp/ 1> /dev/null
    echo "$?"
    cd -
}

# opencode
export PATH=/home/huynh/.opencode/bin:$PATH
