call plug#begin()

" colors
Plug 'https://github.com/morhetz/gruvbox'

" file explorer
Plug 'https://github.com/scrooloose/nerdtree.git'

"search
Plug 'https://github.com/eugen0329/vim-esearch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/denite.nvim'

"navigation
Plug 'unblevable/quick-scope'
Plug 'andymass/vim-matchup'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Valloric/YouCompleteMe'

" syntax
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'w0rp/ale'

" pairs
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" mapping
Plug 'https://github.com/tpope/vim-unimpaired'

" editing
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/tpope/vim-commentary'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" buffers
Plug 'jlanzarotta/bufexplorer'

call plug#end()

" Custom settings{
    " stop breaking lines
    set nowrap
    " Save marks over session
    set viminfo='1000,f1
    " ctags
    set tags=tags
    " colors
    colorscheme gruvbox
    set background=dark
    " open splits in more comfortable positions.
    set splitright
    set splitbelow
    "turn on the feature
    set undofile
    "directory where the undo files will be stored
    set undodir=$HOME/.vim/undo

    set nocompatible " neovim with vim

    set clipboard+=unnamedplus

    set incsearch

    filetype plugin indent on
    " enable search keys insensetive by default
    set ignorecase

    runtime macros/matchit.vim

    set cursorline cursorcolumn
    tnoremap <ESC> <C-\><C-n>
    " for tpope comments 
    autocmd FileType apache setlocal commentstring=#\ %s<Paste>

    "Tabulation {
        set tabstop=4
        set shiftwidth=4
        set expandtab
        autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
        "FileType js setlocal shiftwidth=2 tabstop=4

        " Tell Vim which characters to show for expanded TABs,
        " trailing whitespace, and end-of-lines. VERY useful!
        if &listchars ==# 'eol:$'
          set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
        endif
        set list                " Show problematic characters.

        " Also highlight all tabs and trailing whitespace characters.
        highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
        match ExtraWhitespace /\s\+$\|\t/
    "}
" }

" Custom mapping{
    nnoremap \ ,
    let mapleader = ","

    "control keys
    map <F3> :Mpu <CR>
    map <F4> :terminal<CR>
    map <F5> :set nopaste
    map <F9> :tabe $VIRTUAL_ENV/lib/python*/site-packages/<CR>
    map <F12> :tabe $MYVIMRC<CR>

    "tabs and windows navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    "windows operations
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>q :q<CR>

    "window splits
    nnoremap <Leader>v :vsplit<CR>
    nnoremap <Leader>s :split<CR>

    "registers
    nnoremap <leader>r :registers<CR>

    "buffers
    nnoremap <leader>d :bdelete<CR>

    "copy current file path to work register
    function CopyModulePath()
       let fullpath = split(expand("%"), '/')
       let modulename = join(fullpath, ".")
       :let @m = modulename
       :let @p = expand('%')
       :let @+ = expand('%')
    endfunction

    nnoremap <leader>y :call CopyModulePath()<CR>
" }

" NERDTree {
    let NERDTreeIgnore = ['\.pyc$']
    let NERDTreeShowHidden=1
    map <Leader>n :NERDTreeToggle<CR>
    map <Leader>m :NERDTreeFind<CR>z.
    let NERDTreeMapHelp='<f12>'
    let NERDTreeMapPreview="e"
    " enable line numbers
    let NERDTreeShowLineNumbers=1
    " make sure relative line numbers are used
    autocmd FileType nerdtree setlocal relativenumber
    let g:NERDTreeWinSize=35
    let NERDTreeQuitOnOpen=1
" }

" YouCompleteMe{
    map ,l :YcmCompleter GoToDefinition <CR>
" }

" Ale{
   let g:ale_python_pylint_executable = 'python'
   let g:ale_linters = {
   \ 'python': ['flake8']
   \ }
   let g:ale_python_flake8_options = '--append-config=~/.config/flake8'
   let g:ale_sign_warning = '.'
   let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" }
"

" Abbreviatures
ab pdb import pdb; pdb.set_trace()
ab pudb import pudb; pudb.set_trace()
ab ipdb import ipdb; ipdb.set_trace()
ab csl console.log
ab dbg debugger;


" Fzf {
    map <c-p> :Files<CR>
    map <leader>h :History<CR>
    map <leader>e :Files $VIRTUAL_ENV<CR>
    map <leader>a :Marks<CR>
    map <leader>b :Buffers<CR>
    map <leader>t :Tags<CR>
    map <leader>f :Ag<CR>
    "map <leader>l :Lines<CR>
    autocmd VimEnter * command! -bang -nargs=* Ag
        \ call fzf#vim#ag(<q-args>, '--ignore="*dist*" --ignore="*tags*"', <bang>0)
" }

" esearch{
    let g:esearch = {
      \ 'adapter':    'ag',
      \ 'backend':    'nvim',
      \ 'out':        'win',
      \ 'batch_size': 1000,
      \ 'use':        ['visual', 'hlsearch', 'last'],
      \}
    let g:esearch#adapter#ag#options = '--ignore="*dist*" --ignore="*tags*"'
" }

" emment-vim
let g:user_emmet_leader_key='<C-SPACE>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}


" Relative numbers during navigation, absolute during edit.
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Commands
" Show available django urls in project(without admin urls)
command Mpu execute ":tabe | 0read ! python manage.py show_urls | grep -v 'admin'"
