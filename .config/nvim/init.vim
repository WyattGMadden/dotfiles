


call plug#begin('~/.vim/plugged')
" General {{{
    Plug 'github/copilot.vim' 
    "default have gopilot disabled
    "turn on with :Copilot enable
    let g:copilot_enabled = 0
    let mapleader = ";"
    nnoremap <leader>co :Copilot enable<CR>
    vnoremap <leader>y "+y


    Plug 'w0rp/ale' "Linting
    "Don't use any linters for tex files. 
    let g:ale_linters = {
        \   'tex': [],
        \   'r': ['lintr'],
        \  'julia': [],
    \}

    Plug 'overcache/NeoSolarized' "Color scheme
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' } "Color scheme
    Plug 'ellisonleao/gruvbox.nvim' "Color scheme
    Plug 'EdenEast/nightfox.nvim' "Color scheme
    Plug 'vim-airline/vim-airline' "tabs
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree' "nerdtree
    Plug 'mfussenegger/nvim-dap' "debugging
    Plug 'rcarriga/nvim-dap-ui' "debugging
    Plug 'jalvesaq/Nvim-R'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
        "Plug 'chrisbra/csv.vim'
        "" hpc {{{


    " }}}

    "ft plugins enabled (necessary for csv plugin
    :filetype plugin on

    let R_csv_app = 'terminal:vd'

    " custom nvim-r mappings
    function! s:customNvimRMappings()
        map <silent> <LocalLeader>jl :call g:SendCmdToR("devtools::load_all()")<CR>
        map <silent> <LocalLeader>jd :call g:SendCmdToR("devtools::document()")<CR>
        map <silent> <LocalLeader>jb :call g:SendCmdToR("devtools::build_readme()")<CR>
        map <silent> <LocalLeader>jc :call g:SendCmdToR("devtools::check()")<CR>
    endfunction
    augroup myNvimR
       au!
       autocmd filetype r call s:customNvimRMappings()
       autocmd filetype rmd call s:customNvimRMappings()
    augroup end
    "map  <LocalLeader>s :call g:SendCmdToR("search()")<CR>

    " mappings
    " remapping the basic :: send line
    nmap <Space> <Plug>RDSendLine
    " remapping selection :: send multiple lines
    vmap <Space> <Plug>RDSendSelection
    " map pipe  
    autocmd FileType r inoremap <buffer> Â <Space>\|>
    autocmd FileType rnoweb inoremap <buffer> Â <Space>\|>
    autocmd FileType rmd inoremap <buffer> Â <Space>\|>

    "reassign assignment
    autocmd FileType r inoremap <buffer> Å <Space><-<Space>
    autocmd FileType rnoweb inoremap <buffer> Å <Space><-<Space>
    autocmd FileType rmd inoremap <buffer> Å <Space><-<Space>
    let R_assign_map = 'Å'

    "reassign assignment
    autocmd FileType r inoremap <buffer> ı <Esc>:normal! abrowser()<CR>a


    
    " set a minimum source editor width
    let R_min_editor_width = 80

    " make sure the console is at the bottom by making it really wide
    let R_rconsole_width = 1000

    " show arguments for functions during omnicompletion
    let R_show_args = 1

    " Don't expand a dataframe to show columns by default
    let R_objbr_opendf = 0


" }}}
" vim slime {{{
    Plug 'jpalardy/vim-slime'
    let g:slime_target = "tmux" 
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{next}"}
    let g:slime_python_ipython = 1
    let g:slime_preserve_curpos = 0 "don't preserve cursor position when sending code
"    let g:slime_no_mappings = 1 "don't define default mappings
    autocmd FileType python nmap <buffer> <LocalLeader>l <Plug>SlimeLineSend
    autocmd FileType python nmap <buffer> <LocalLeader>c <Plug>SlimeParagraphSend
    autocmd FileType python xmap <buffer> <LocalLeader>c <Plug>SlimeRegionSend
    autocmd FileType python nmap <buffer> <LocalLeader>q :call slime#send("quit()\n") <CR>`
    autocmd FileType python nmap <buffer> <LocalLeader>i :call slime#send("i\n") <CR>`

    autocmd FileType r nmap <buffer> <LocalLeader>l <Plug>SlimeLineSend
    autocmd FileType r nmap <buffer> <LocalLeader>c <Plug>SlimeParagraphSend
    autocmd FileType r xmap <buffer> <LocalLeader>c <Plug>SlimeRegionSend
    autocmd FileType r nmap <buffer> <LocalLeader>q :call slime#send("quit()\n") <CR>`
    autocmd FileType r nmap <buffer> <LocalLeader>i :call slime#send("i\n") <CR>`

    autocmd FileType julia nnoremap <buffer> <LocalLeader>l <Plug>SlimeLineSend
    autocmd FileType julia xmap    <buffer> <LocalLeader>c <Plug>SlimeRegionSend
    autocmd FileType julia nnoremap <buffer> <LocalLeader>r :SlimeSend0<CR>

    "xmap <LocalLeader>cc <Plug>SlimeRegionSend
    "nmap <c-c><c-c> <Plug>SlimeParagraphSend
    "nmap <c-c>v     <Plug>SlimeConfig

    "nnoremap <C-q> :call slime#send("quit()\n") <CR>`
    "nnoremap <C-q> :call slime#send("quit()\n") <CR>`


"}}}
"
" stan {{{
    Plug 'eigenfoo/stan-vim'
"}}}
"
" Julia {{{
    let g:coc_global_extensions = ['coc-julia']
    nnoremap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> K  <Plug>(coc-hover)
    nnoremap <silent> <leader>rn <Plug>(coc-rename)
    nnoremap <silent> <leader>ca <Plug>(coc-codeaction)
"}}}
"
" pyvim: {{{
    Plug 'jupyter-vim/jupyter-vim'
    let g:jupyter_highlight_cells = 0

" }}}
"

" Autocomplete/snippets etc {{{
    Plug 'roxma/nvim-yarp'
    Plug 'sirver/UltiSnips'
    Plug 'lervag/vimtex' "for tex

    " Press enter key to trigger snippet expansion
    " The parameters are the same as `:help feedkeys()`
    let g:UltiSnipsExpandTrigger="<tab>"

    " c-j c-k for moving in snippet
    let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
    let g:UltiSnipsRemoveSelectModeMappings = 0

    " Use <TAB> to select the popup menu:
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


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


    """""""""""""""""""""""
    "python specific
    """""""""""""""""""""""
    "disable python3 warning
"    let g:loaded_python3_provider = 0
    "let g:python3_host_prog = '~/anaconda3/bin/python3'
    "let g:python3_host_prog = '~/miniconda3/bin/python3'
"    if hostname() =~ 'emorycomputer'
"        let g:python3_host_prog = '/Users/wmadden/miniconda3/envs/neovim-python/bin/python'
"    endif
    let g:python3_host_prog = expand('~/.config/nvim/venv/bin/python')

    

    """""""""""""""""""""""
    "julia specific
    """""""""""""""""""""""
    autocmd BufWritePre *.jl silent! call CocAction('format')


" }}}





