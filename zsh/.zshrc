# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
#command cowsay $(fortune)
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="arrow"

export EDITOR=vim

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
 DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
 COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git aliases ruby gem rails bundler tmuxinator)

source $ZSH/oh-my-zsh.sh
#. /home/bukowski/git/vim-on-steroids/powerline/powerline/bindings/zsh/powerline.zsh
# Customize to your needs...

# /etc/inputrc initialization file for readline
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" history-search-backward
bindkey "\e[6~" history-search-forward
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word
bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word
bindkey "\e[8~" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

PATH=$PATH:$HOME/bin:$HOME/.rvm/bin:/usr/local/heroku/bin

#PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/lib/mailman/bin:/opt/metasploit:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/bin:/usr/local/bin:/usr/local/heroku/bin:$HOME/.rvm/bin

[ -f ~/.zsh_functions ] && source ~/.zsh_functions

#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/devel
#source /usr/bin/virtualenvwrapper.sh
#[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Enable powerline plugin
#. /usr/share/zsh/site-contrib/powerline.zsh
#export PYTHONPATH=/usr/lib/python3.4/site-packages
