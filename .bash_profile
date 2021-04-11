
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

