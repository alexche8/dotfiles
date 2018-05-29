call plug#begin()
Plug 'https://github.com/freeo/vim-kalisi'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/eugen0329/vim-esearch'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

Plug 'Valloric/YouCompleteMe'

Plug 'w0rp/ale'

Plug 'jiangmiao/auto-pairs'

"Plug 'tpope/vim-surround'
"Plug 'unblevable/quick-scope'

call plug#end()

" Custom settings{
    " stop breaking lines
    set nowrap
    " Save marks over session
    set viminfo='1000,f1
    " ctags
    set tags=tags
    " colors
    colorscheme kalisi
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

    filetype plugin indent on

    "Tabulation {
        set tabstop=4
        set shiftwidth=4
        set expandtab

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
    map <F12> :tabe $MYVIMRC<CR>
    map <F9> :tabe $VIRTUAL_ENV/lib/python*/site-packages/<CR>

    "tabs navigation
    map - <c-w>w
    map _ <c-w>p

    "buffers
    nnoremap s :bn<CR>
    nnoremap S :bp<CR>
    nnoremap = :windo bd<CR> :bn<CR>

    "windows operations
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>q :q<CR>

    "windows operations
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>q :q<CR>

    " Add blank lines
    nnoremap <c-k> m`O<esc>``
    nnoremap <c-j> m`o<esc>``
    inoremap <c-j> <esc>m`o<esc>``a
    inoremap <c-k> <esc>m`O<esc>``a

    "copy current file path to work register
    function CopyModulePath()
       let fullpath = split(expand("%"), '/')
       let modulename = join(fullpath, ".")
       :let @" = modulename
    endfunction

    nnoremap <leader>r :call CopyModulePath()<CR>
    nnoremap <leader>R :let @" = expand('%')<CR>
" }

" NERDTree {
    let NERDTreeIgnore = ['\.pyc$']
    let NERDTreeShowHidden=1
    map <Leader>n :NERDTreeToggle<CR>
    map <Leader>m :NERDTreeFind<CR>
    let NERDTreeMapPreview="e"
    " enable line numbers
    let NERDTreeShowLineNumbers=1
    " make sure relative line numbers are used
    autocmd FileType nerdtree setlocal relativenumber
    let g:NERDTreeWinSize=35
    let NERDTreeQuitOnOpen=1
" }

" YouCompleteMe{
    map <c-l> :YcmCompleter GoToDefinition <CR>
" }

" Ale{
   let g:ale_python_pylint_executable = 'python'
   let g:ale_linters = {
   \ 'python': ['flake8']
   \ }
   let g:ale_python_flake8_options = '--append-config=~/.config/flake8'
" }
"

" Abbreviatures
ab pdb import pdb; pdb.set_trace()
ab pudb import pudb; pudb.set_trace()
ab ipdb import ipdb; ipdb.set_trace()


" Fzf {
    map <c-p> :Files<CR>
    map <leader>h :History<CR>
    map <leader>v :Files $VIRTUAL_ENV<CR>
    map <leader>a :Marks<CR>
    map <leader>b :Buffers<CR>
    map <leader>t :Tags<CR>
    map <leader>l :Lines<CR>
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

    " search with additional options
    fu! EsearchWithOptions(argv, lang) abort
      let original = g:esearch#adapter#ag#options
      if a:lang == 1
          let g:esearch#adapter#ag#options = '--py'
      elseif a:lang == 2
          let g:esearch#adapter#ag#options = '--js'
      elseif a:lang == 0
          let g:esearch#adapter#ag#options = input('Search options: ')
      endif
      call esearch#init(a:argv)
      let g:esearch#adapter#ag#options = original
    endfu

    " search with input options
    noremap  <silent><leader>F :<C-u>call EsearchWithOptions({}, 0)<CR>
    xnoremap <silent><leader>F :<C-u>call EsearchWithOptions({'visualmode': 1})<CR>

    " quick search python files
    noremap  <silent><leader>fp :<C-u>call EsearchWithOptions({}, 1)<CR>
    xnoremap <silent><leader>fp :<C-u>call EsearchWithOptions({'visualmode': 1})<CR>

    " quick search python files
    noremap  <silent><leader>fj :<C-u>call EsearchWithOptions({}, 2)<CR>
    xnoremap <silent><leader>fj :<C-u>call EsearchWithOptions({'vi1ualmode': 2})<CR>

" }

" Relative numbers during navigation, absolute during edit.
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Commands
command Mpu execute ":tabe | 0read ! python manage.py show_urls | grep -v 'admin'"

