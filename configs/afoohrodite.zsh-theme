#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Aphrodite Terminal Theme
#
# Author: Sergei Kolesnikov
# https://github.com/win0err/aphrodite-terminal-theme
#
# ------------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{155}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%f%F{131}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

aphrodite_get_welcome_symbol() {

	echo -n "%(?..%F{1})"
	
	local welcome_symbol=''
	[ $EUID -ne 0 ] || welcome_symbol='#'
	
	echo -n $welcome_symbol
	echo -n "%(?..%f)"
}

# local aphrodite_get_time="%F{grey}[%*]%f"

aphrodite_get_current_branch() {

	local branch=$(git_current_branch)
	
	if [ -n "$branch" ]; then
		echo -n $ZSH_THEME_GIT_PROMPT_PREFIX
		echo -n $(parse_git_dirty)
		echo -n "‹${branch}›"
		echo -n $ZSH_THEME_GIT_PROMPT_SUFFIX
	fi
}

aphrodite_get_prompt() {

	# 256-colors check (will be used later): tput colors
        
        echo -n "%F{255}╭─%F{69}${rvm_ruby} %* " # Date 
	echo -n "%F{253}%n%f" # User
	#echo -n "%F{8}@%f" # at
	#echo -n "%F{250}%m%f" # Host
	echo -n "%F{75}: %f" # in 
	echo -n "%F{75}%~" # Dir
	echo -n "$(aphrodite_get_current_branch)" # Git branch
        echo -n "\n" 
	echo -n "%F{255}╰─$(aphrodite_get_welcome_symbol)%{$reset_color%} " # $ or #
}

export GREP_COLOR='1;31'

PROMPT='$(aphrodite_get_prompt)'

