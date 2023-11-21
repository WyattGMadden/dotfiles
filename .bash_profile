

#kitty 
if [ "$(hostname)" == "wyatts-MacBook-Pro.local" ]; then
    # Commands to run when not on HPC
	source /dev/stdin <<<"$(kitty + complete setup bash)"

fi


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

##########################
###########PATHS##########
##########################
#


if [ "$(hostname)" == "wyatts-MacBook-Pro.local" ]; then
    #PATH="/usr/local/bin:$PATH" #https://gist.github.com/shawnbot/3277580
    #
    ## Setting PATH for Python 3.
    ## The original version is saved in .bash_profile.pysave
    PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
    export PATH

    # added by Anaconda3 5.2.0 installer
    export PATH="/Users/wyattmadden/anaconda3/bin:$PATH"
    export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH

    #macports path
    export PATH=$PATH:/opt/local/bin
fi

#nvim path if on hpc
if [ "$(hostname)" == "clogin01" ]; then
	export PATH="$HOME/apps/nvim-linux64/bin:$PATH"
fi



#load fasd in on macbook (not hpc)
if [ "$(hostname)" == "wyatts-MacBook-Pro.local" ]; then
    # Commands to run when not on HPC
	eval "$(fasd --init auto)"

fi


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



##################
###ADD API KEYS###
##################
if [ -f ~/.secrets.sh ]; then
  source ~/.secrets.sh
fi



#############
###ALIASES###
#############
alias c="cd"
alias l="ls"
alias m="mkdir"
alias v="nvim"
alias mu="mupdf-gl"
alias i="ipython"
alias jc="jupyter console"
alias matlab="/Applications/MATLAB_R2022b.app/bin/matlab -nojvm -nodesktop"
alias brave="open -a 'Brave Browser'"
alias sshw="ssh wmadden@clogin01.sph.emory.edu"

alias ga="git add"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gpom="git push origin main"
alias gpullom="git pull origin main"

#hpc specific
if [ "$(hostname)" == "clogin01" ]; then
    alias i='conda activate ml_dl_env && srun -p interactive-cpu --pty ipython'
    alias r='(module load R && srun -p interactive-cpu --pty R)'
    alias sqw="squeue -u wmadden"

fi



###############
###FUNCTIONS###
###############

### send files to the cluster
scpwto () {
    scp -r "$1" "wmadden@clogin01.sph.emory.edu:./$2"
}

### return files from the cluster
scpwfrom () {
    scp -r "wmadden@clogin01.sph.emory.edu:./$1" "$2"
}

### Create a new Rmd file
rmd() {
  if [ -z "$1" ]; then
    echo "Please provide the file name."
    return 1
  fi

  cat << EOF > "$1.Rmd"
---
title: "Analysis"
author: "Wyatt Madden"
date: "`date +'%Y-%m-%d'`"
output: pdf_document
---

# Introduction

Write your content here.

EOF
  echo "File $1.Rmd created."
}


### Create a new md file
md() {
    if [ $# -lt 1 ]; then
        echo "Usage: create_md_template <filename> [author]"
        return 1
    fi

    filename="$1.md"
    author="${2:-Wyatt Madden}"
    date="$(date +'%Y-%m-%d')"

    cat > "$filename" <<EOL
---
title: "Post"
subtitle: ""
author: $author
description: ""
institute: ""
date: $date
abstract: "YAML"
keywords: 
tags:
---


## Introduction

## Section 1

### Subsection 1.1

## Section 2

### Subsection 2.1

## Conclusion

## References
EOL

    echo "Created $filename"
}



################################
###Create a new LaTeX project###
################################
tex_init() {
    # Check if a directory name is provided
    if [ "$#" -ne 1 ]; then
        echo "Usage: create_latex_project <directory_name>"
        return 1
    fi

    # Create the directory and navigate into it
    mkdir -p "$1"
    cd "$1" || return

    # Create the main LaTeX file
    cat > main.tex <<- 'EOF'
\documentclass[12pt]{article}
\usepackage[margin=1in]{geometry} % Set margins
\usepackage[utf8]{inputenc}
\usepackage{biblatex} % Biblatex package
\addbibresource{references.bib} % BibTeX bibliography file

\title{Report}
\author{Wyatt Madden}
\date{\today}

\begin{document}

\maketitle

\section{Introduction}
Your text here.

\section{Conclusion}
Your text here.

\printbibliography

\end{document}
EOF

    # Create an empty BibTeX file
    touch references.bib

    echo "LaTeX project created in directory $1"
}

# Usage: create_latex_project <directory_name>


#################################
###Move latest download to pwd###
#################################
mv_download() {
    # Define the Downloads directory (modify if different)
    downloads_folder="$HOME/Downloads"

    # Find the most recent file in Downloads
    recent_file=$(ls -t "$downloads_folder" | head -n1)

    # Check if a file was found
    if [ -z "$recent_file" ]; then
        echo "No files found in Downloads."
        return 1
    fi

    # Move the most recent file to the current directory
    mv "$downloads_folder/$recent_file" .

    echo "$recent_file has been moved to the current directory."
}

# Usage: move_latest_download



#render md to html
pmd() {
  input_file="$1"
  output_file="${input_file%.md}.html"
  pandoc -s "$input_file" -o "$output_file" --mathjax
}

#create file and open in nvim
tv() {
  touch "$1"
  nvim "$1"
}


#Download youtube to flac
ytflac() {
  local url="$1"
  yt-dlp -f 'bestaudio/best' \
         --verbose \
         --extract-audio \
         --audio-format flac \
         --audio-quality 0 \
         "$url"
}

#take multiple steps back
cdb() {
    local steps=$1
    local path=""
    for ((i=0; i<steps; i++)); do
        path+="../"
    done
    cd $path
}

######################
#####HPC SPECIFIC######
######################

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
if [ -n $R_LIBS ]; then
      export R_LIBS=~/Rlibs:$R_LIBS
else
      export R_LIBS=~/Rlibs
fi


echo "Sourcing .bash_profile"




##
# Your previous /Users/wyattmadden/.bash_profile file was backed up as /Users/wyattmadden/.bash_profile.macports-saved_2023-10-22_at_09:26:18
##

# MacPorts Installer addition on 2023-10-22_at_09:26:18: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2023-10-22_at_09:32:17: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2023-10-22_at_09:39:08: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

