
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
alias t="trash"
alias v="nvim"
alias mu="mupdf-gl"
alias i="ipython"
alias jc="jupyter console"
alias matlab="/Applications/MATLAB_R2022b.app/bin/matlab -nojvm -nodesktop"
alias brave="open -a 'Brave Browser'"

#for cluster
alias sshw="ssh wmadden@clogin01.sph.emory.edu"
alias sqw="squeue -u wmadden"

alias ca="conda activate finalmlenv"

alias ga="git add"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gpom="git push origin main"
alias gpullom="git pull origin main"


###############
###FUNCTIONS###
###############

### python environ for linux desktop tmux
cai() {
    conda activate finalmlenv
    ipython
}

### send files to the cluster
scpwto () {
    scp -r "$1" "wmadden@clogin01.sph.emory.edu:./$2"
}

### return files from the cluster
scpwfrom () {
    scp -r "wmadden@clogin01.sph.emory.edu:./$1" "$2"
}

### send files to other
scp_to() {
    local server_alias=$1
    local local_file_path=$2
    local remote_file_path=$3
    scp -r "$local_file_path" "${server_alias}:${remote_file_path}"
}

### return files from other
scp_from() {
    local server_alias=$1
    local remote_file_path=$2
    local local_file_path=$3
    scp -r "${server_alias}:${remote_file_path}" "$local_file_path"
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
\usepackage[backend=biber, style=numeric, sorting=none]{biblatex}
\usepackage{amsmath}
\usepackage{amssymb}
\addbibresource{references.bib} % BibTeX bibliography file
\newcommand{\bs}{\boldsymbol}
\newcommand{\bl}{\mathbf}

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

#DownLoads Here
#move recent files from downloads directory to current directory
dlh() {
  # Define the Downloads directory
  DOWNLOADS_DIR=~/Downloads

  # Find files in the Downloads directory that were modified in the last 10 minutes
  # and move them to the current working directory
  find "$DOWNLOADS_DIR" -type f -mmin -10 -exec mv {} . \;
}



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/wyattgmadden/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/wyattgmadden/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/wyattgmadden/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/wyattgmadden/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

