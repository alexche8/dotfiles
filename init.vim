call plug#begin()

" meta
"Plug 'https://github.com/liuchengxu/vim-which-key'

" visual
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/RRethy/vim-illuminate'
"Plug 'ryanoasis/vim-devicons'

" file explorer
Plug 'https://github.com/scrooloose/nerdtree.git'

"search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/eugen0329/vim-esearch'

"navigation
Plug 'unblevable/quick-scope'
Plug 'andymass/vim-matchup'
Plug 'jeetsukumaran/vim-pythonsense'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Valloric/YouCompleteMe'
Plug 'https://github.com/davidhalter/jedi-vim'

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
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" statusline
Plug 'https://github.com/vim-airline/vim-airline'

" learn
Plug 'takac/vim-hardtime'

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
        autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab
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
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
" }

" Custom mapping{
    nnoremap \ ,
    let mapleader = ","

    "navigation

    "control keys
    map <F3> :Mpu <CR>
    "map <F4> :CtagsUpdate <CR>
    map <F5> :terminal<CR>
    set pastetoggle=<F6>
    map <F9> :tabe $VIRTUAL_ENV/lib/python*/site-packages/<CR>

    map <F7> :PlugInstall<CR>
    map <F8> :PlugClean<CR>
    map <F12> :tabe $MYVIMRC<CR>

    "tabs and windows navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    "windows operations
    nnoremap <Leader>w :w<CR>
    "register
    nnoremap <Leader>. :registers<CR>

    "buffers
    "nnoremap <leader>z :bp\|bd #<CR> :bn<CR>

    "close tab but keep buffer
    nnoremap <Leader>q :q<CR>
    "delete buffer
    nnoremap <leader>x :bd<CR>
    "delete buffer but keep window
    nnoremap <leader>z :bp\|bd #<CR>
    nnoremap <leader>v :buffers<CR>
    "alt key file operations
    nnoremap <leader>fe :edit!<CR>
    nnoremap <leader>fq :quit!<CR>

    "copy current file path to work register
    function! CopyModulePath()
       let fullpath = split(expand("%"), '/')
       let modulename = join(fullpath, ".")
       :let @m = modulename
       :let @p = expand('%')
       :let @+ = expand('%')
    endfunction

    nnoremap <leader>y :call CopyModulePath()<CR>
    nnoremap <A-'> :ReloadVimrc <CR>

" }

" NERDTree {
    let NERDTreeIgnore = ['\.pyc$']
    let NERDTreeShowHidden=1
    " enable line numbers
    let NERDTreeShowLineNumbers=1
    " make sure relative line numbers are used
    autocmd FileType nerdtree setlocal relativenumber
    let g:NERDTreeWinSize=35
    let NERDTreeQuitOnOpen=1

    " mapping
    map <Leader>m :NERDTreeFind<CR>z.
    map <Leader>n :NERDTreeToggle<CR>
    let NERDTreeMapOpenVSplit='v'
    let NERDTreeMapOpenSplit='x'
    let NERDTreeMapCloseDir='i'
    let NERDTreeMapPreview="e"
    let NERDTreeMapHelp='<f12>'
" }

" YouCompleteMe{
    map <leader>l :YcmCompleter GoToDefinition <CR>
" }

" Ale{
   " common and python
   let g:ale_python_pylint_executable = 'python'
   let g:ale_linters = {
   \ 'python': ['flake8']
   \ }
   let g:ale_python_flake8_options = '--config max-line-length = 79'
   let g:ale_python_autopep8_options = '--global-config ~/.config/flake8'
   let g:ale_sign_error = 'x'
   let g:ale_sign_warning = '~'
   let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

   let g:ale_fixers = {
    \   'javascript': [
    \      'prettier', 'eslint'
    \   ],
    \   'python': ['autopep8']
    \}

    nmap <A-f> :ALEFix<CR>
" }
"

" illuminate{
   let g:Illuminate_ftblacklist = ['nerdtree']
" }


" Fzf {
    map <c-p> :Files<CR>

    map <leader>e :Files $VIRTUAL_ENV<CR>

    map <leader>a :Marks<CR>
    map <leader>b :Buffers<CR>
    map <leader>t :Tags<CR>
    map <leader>s :Lines<CR>

    map <leader>h :History<CR>
    map <leader>: :History:<CR>
    map <leader>/ :History/<CR>

    let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude="*static/dist*" --exclude="*static/vendor*" --exclude="*.css" --exclude="*cassettes*"'
    autocmd! FileType fzf tnoremap <buffer> <leader>q <c-c>
" }

"  esearch{
    let g:esearch = {
      \ 'adapter':    'ag',
      \ 'backend':    'nvim',
      \ 'out':        'win',
      \ 'batch_size': 1000,
      \ 'use':        ['visual', 'hlsearch', 'last'],
      \}
    call esearch#out#win#map('x', 'split')
    call esearch#out#win#map('v', 'vsplit')
    let g:esearch#adapter#ag#options = '--ignore="*dist*" --ignore="*tags*"'

    fu! EsearchInFiles(argv) abort
      let original = g:esearch#adapter#ag#options
      let g:esearch#adapter#ag#options = input('Search options: ')
      call esearch#init(a:argv)
      let g:esearch#adapter#ag#options = original
    endfu

    " replace these mapping with the ones you prefer
    noremap  <silent><leader>ft :<C-u>call EsearchInFiles({})<CR>
    xnoremap <silent><leader>ft :<C-u>call EsearchInFiles({'visualmode': 1})<CR>
    noremap <silent><leader>fa :Ag<CR>
" }

" jedi{
  let g:jedi#usages_command = "<Leader>u"
" }

" emment-vim{
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
" }

" Relative numbers during navigation, absolute during edit.
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" ultisnips{
    let g:UltiSnipsExpandTrigger = '<A-Enter>'
    "let g:UltiSnipsJumpForwardTrigger = '<A-j>'
    "let g:UltiSnipsJumpBackwardTrigger = '<A-k>'
" }

" hardtime {
    let g:hardtime_default_on = 0
" }

" ctags{
    map <A-u> :CtagsUpdate <CR>
" }

" vim-pythonsence{
   let g:is_pythonsense_suppress_motion_keymaps = 1
"}


" Commands
" Show available django urls in project(without admin urls)
command! Mpu execute ":tabe | 0read ! python manage.py show_urls | grep -v 'admin'"
" Update ctags from fzf command
command! CtagsUpdate call system(get(g:, 'fzf_tags_command')) | echo "tags updated"
" Reload vimrc
command! ReloadVimrc execute ":so $MYVIMRC | echo 'init.vim reloaded'"
