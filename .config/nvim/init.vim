
" General {{{

    "set numbering
    set number relativenumber

    "set true colors 
    set termguicolors

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

" }}}



call plug#begin('~/.vim/plugged')
" General {{{
    Plug 'w0rp/ale' "Linting
" }}}

" Nvim-R {{{
    Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
    Plug 'chrisbra/csv.vim'

    "ft plugins enabled (necessary for csv plugin
    :filetype plugin on

    " mappings
    " remapping the basic :: send line
    nmap <Space> <Plug>RDSendLine
    " remapping selection :: send multiple lines
    vmap <Space> <Plug>RDSendSelection
    " map pipe  
    autocmd FileType r inoremap <buffer> M <Esc>:normal! a %>%<CR>a 
    autocmd FileType rnoweb inoremap <buffer> M <Esc>:normal! a %>%<CR>a 
    autocmd FileType rmd inoremap <buffer> M <Esc>:normal! a %>%<CR>a
    "reassign assignment
    let R_assign_map = 'A'
" }}}

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


call plug#end()
