# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# zsh specfic

### History ###
HISTFILE=~/.zsh_history   # file to save history
HISTSIZE=10000            # size of history
SAVEHIST=10000            # number of history
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # add executed time into history
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# general
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# alias
alias ll="ls -l"
alias la="ls -la"
alias lh="ls -lh"
alias v="nvim"

# docker
#alias evalde="eval $(docker-machine env default)"
#evalde

# ruby/rbenv
eval "$(rbenv init -)"

# go
export GOPATH=~/dev/repo
export PATH=$PATH:$GOPATH/bin

# Search shell history with peco: https://github.com/peco/peco
# Adapted from: https://github.com/mooz/percol#zsh-history-search
if which peco &> /dev/null; then
	function peco_select_history() {
		local tac
		(which gtac &> /dev/null && tac="gtac") || \
			(which tac &> /dev/null && tac="tac") || \
			tac="tail -r"
		BUFFER=$(fc -l -n 1 | eval $tac | \
								peco --layout=bottom-up --query "$LBUFFER")
		CURSOR=$#BUFFER # move cursor
		zle -R -c       # refresh
	}

	zle -N peco_select_history
	bindkey '^R' peco_select_history
fi

#function title {
#  echo -ne "\033]0;"$*"\007"
#}

# set iTerm tab title to the current dir
precmd() {
  echo -ne "\e]1;${PWD##*/}\a"
}

# neovim
export XDG_CONFIG_HOME=~/.config
