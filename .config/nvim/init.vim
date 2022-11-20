

call plug#begin('~/.vim/plugged')
" General {{{
    Plug 'w0rp/ale' "Linting
    Plug 'jpalardy/vim-slime'
    let g:slime_target = "tmux" 
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom}"}
    let g:slime_python_ipython = 1
    Plug 'overcache/NeoSolarized' "Color scheme
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' } "Color scheme
    Plug 'ellisonleao/gruvbox.nvim' "Color scheme
    Plug 'EdenEast/nightfox.nvim' "Color scheme
    Plug 'vim-airline/vim-airline' "tabs
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree' "nerdtree
    """""""""""""""""""""
    """NERDTree Plugin"""
    """""""""""""""""""""
    " Opens NERDTree with custom shortcut, here 'zz'
    let mapleader = "z" 
    nmap <leader>z :NERDTreeToggle<cr>

    " Instruct NERDTree to always opens in the current folder
    set autochdir
    let NERDTreeChDirMode=2
    nnoremap <leader>n :NERDTree .<CR>

    " Optional to show special NERDTree browser characters properly (e.g. on remote linux system) 
    let g:NERDTreeDirArrows=0

    " Show bookmarks by default
    let NERDTreeShowBookmarks=1
    """""""""""""""""""""""

" }}}

" Nvim-R {{{
    Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
    "Plug 'chrisbra/csv.vim'

    "ft plugins enabled (necessary for csv plugin
    :filetype plugin on

    let R_csv_app = 'terminal:vd'

    " mappings
    " remapping the basic :: send line
    nmap <Space> <Plug>RDSendLine
    " remapping selection :: send multiple lines
    vmap <Space> <Plug>RDSendSelection
    " map pipe  
    autocmd FileType r inoremap <buffer> Â <Esc>:normal! a %>%<CR>a 
    autocmd FileType rnoweb inoremap <buffer> Â <Esc>:normal! a %>%<CR>a 
    autocmd FileType rmd inoremap <buffer> Â <Esc>:normal! a %>%<CR>a

    "reassign assignment
    autocmd FileType r inoremap <buffer> Å <Esc>:normal! a <-<CR>a 
    autocmd FileType rnoweb inoremap <buffer> Å <Esc>:normal! a <-<CR>a
    autocmd FileType rmd inoremap <buffer> Å <Esc>:normal! a <-<CR>a
    let R_assign_map = 'Å'

    
    " set a minimum source editor width
    let R_min_editor_width = 80

    " make sure the console is at the bottom by making it really wide
    let R_rconsole_width = 1000

    " show arguments for functions during omnicompletion
    let R_show_args = 1

    " Don't expand a dataframe to show columns by default
    let R_objbr_opendf = 0
" }}}
"
" stan {{{
    Plug 'eigenfoo/stan-vim'
"}}}
"
" pyvim: {{{
    Plug 'jupyter-vim/jupyter-vim'
" }}}
"

" Autocomplete/snippets etc {{{
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'sirver/UltiSnips'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'gaalcaras/ncm-R' "for R
    Plug 'lervag/vimtex' "for tex

    " Press enter key to trigger snippet expansion
    " The parameters are the same as `:help feedkeys()`
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    let g:UltiSnipsExpandTrigger="<tab>"

    " c-j c-k for moving in snippet
    let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
    let g:UltiSnipsRemoveSelectModeMappings = 0

    " Use <TAB> to select the popup menu:
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
" }}}

    "LATEX
    Plug 'lervag/vimtex'

    "fix biber problem
    "let g:Tex_BibtexFlavor = 'biber'
    "let g:Tex_DefaultTargetFormat="pdflatex"
    " The following is relevant to make LaTeX rerun after biber if necessary: 
    " (include all formats for which re-running is to be enabled)
    let g:Tex_MultipleCompileFormats='pdf,bib,pdf'
    "run biber shortcut
    "map <Leader>lb :<C-U>exec '!biber '.Tex_GetMainFileName(':p:t:r')<CR>

call plug#end()



" General {{{
    
    """key bindings

    " move among buffers with CTRL
    map <C-J> :bnext<Shift>
    map <C-K> :bprev<Shift>
    :tnoremap <Esc> <C-\><C-n>


    "set numbering
    set number relativenumber

    "set true colors 
    set termguicolors
    
    "set colorscheme
    "colorscheme tokyonight-storm
    "colorscheme southernlights
    "set background=light
    colorscheme carbonfox
    "set background=dark " or light if you want light mode
    "colorscheme gruvbox

    "tmux hack to make truecolor work
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum

    "set Leader and LocalLeader
    let mapleader = ","
    let maplocalleader = ";"

    "set tab settings
    filetype plugin indent on
    " show existing tab with 4 spaces width
    set tabstop=4
    " when indenting with '>', use 4 spaces width
    set shiftwidth=4
    " On pressing tab, insert 4 spaces
    set expandtab

    "buffer tab settings
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1

    
    
" }}}



