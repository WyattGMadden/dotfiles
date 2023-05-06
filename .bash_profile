#kitty 
source /dev/stdin <<<"$(kitty + complete setup bash)"

# Color
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#from southern lights nvim-R colorscheme github  https://github.com/jalvesaq/southernlights
if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-256color" ]
then
    export TERM=xterm-256color
    export HAS_256_COLORS=yes
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
    export TERM=screen-256color
fi


#PATH="/usr/local/bin:$PATH" #https://gist.github.com/shawnbot/3277580

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# added by Anaconda3 5.2.0 installer
export PATH="/Users/wyattmadden/anaconda3/bin:$PATH"
export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH



eval "$(fasd --init auto)"


### Run tmux when terminal is opened
# If there is a session, attach to it
 tmux attach &> /dev/null
# If not running interactively, do not do anything
 [[ $- != *i* ]] && return
# Otherwise start tmux
 [[ -z "$TMUX" ]] && exec tmux

#vim inline terminal
set -o vi

#see current path
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] [\w]\[\033[00m\]'

### Functions
 aa_256 () { ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`; for i in {0..256}; do o=00$i; echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x; done ) }

#mkdir and cd at same time
 mkcd () {
  mkdir "$1"
  cd "$1"
}



###ALIASES###
alias mu="mupdf-gl"
alias i="ipython"
alias jc="jupyter console"
alias matlab="/Applications/MATLAB_R2022b.app/bin/matlab -nojvm -nodesktop"
alias brave="open -a 'Brave Browser'"
alias l='command ls -Av1h --color=always --time-style='+%Y-%b-%d' --group-directories-first'
    # -A: show all, including dotfiles, except . and ..
    # -v: natural sort of number
    # -1 (one): list (use -l for long version)
    # -h: human-readable sizes
