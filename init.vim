" Installation:
" 1. Install pip3 install --user neovim
" 2. pip3 install pynvim 
" 3. sudo apt-get install xsel
" 4. pip install --user autopep8 flake8
call plug#begin()

" git 
Plug 'tpope/vim-fugitive'

" visual
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/RRethy/vim-illuminate'

" file explorer
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/tpope/vim-vinegar'

"search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/eugen0329/vim-esearch'

"navigation
Plug 'unblevable/quick-scope'
Plug 'jeetsukumaran/vim-pythonsense'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" pairs
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" mapping
Plug 'https://github.com/tpope/vim-unimpaired'

" editing
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/tpope/vim-commentary'

" statusline
Plug 'https://github.com/vim-airline/vim-airline'

call plug#end()

" environment

    let g:python3_host_prog = '/home/alexandr/.virtualenvs/nvim/bin/python'

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
        autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab
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
    "map <F5> :terminal<CR>
    set pastetoggle=<F6>
    map <F9> :tabe $VIRTUAL_ENV/lib/python*/site-packages/<CR>

    "map <F7> :PlugInstall<CR>
    "map <F8> :PlugClean<CR>
    map <F12> :tabe $MYVIMRC<CR>

    "tabs and windows navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    nnoremap <A-h> gT
    nnoremap <A-l> gt
    " nnoremap <> gT

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

    "copy current file path to work register
    function! CopyModulePath()
       let fullpath = split(expand("%"), '/')
       let modulename = join(fullpath, ".")
       :let @m = modulename
       :let @p = expand('%')
       :let @+ = expand('%')
    endfunction

    "copy content of default register to z register
    function! CopyRegister()
       :let @z=@"
    endfunction

    "insert format blocks
    function! InsertFormat()
        :'<,'>w! > /tmp/tmp.py
    endfunction

    nnoremap <leader>y :call CopyModulePath()<CR>
    nnoremap <leader>c :call CopyRegister()<CR>
    vnoremap <leader>g :call InsertFormat()<CR>
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
    let NERDTreeMapPreview="f"
    let NERDTreeMapHelp='<f12>'
" }


" Fzf {
    fu! OpenCWD() abort
        let $VIM_CWD = expand('%:p:h') 
        :Files $VIM_CWD
    endfu

    map <leader>o :call OpenCWD()<CR>
    map <c-p> :Files<CR>
    noremap <silent><leader>l :Lines<CR>
    noremap <silent><leader>f :Ag<CR>
    map <leader>b :Buffers<CR>
    map <leader>h :History<CR>
    map <leader>a :Marks<CR>

    map <leader>e :Files $VIRTUAL_ENV<CR>
    map <leader>E :Ag $VIRTUAL_ENV<CR>

    map <leader>t :Tags<CR>

    map <leader>: :History:<CR>
    map <leader>/ :History/<CR>

    let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude="*static/dist*" --exclude="*static/vendor*" --exclude="*.css" --exclude="*cassettes*"'
    autocmd! FileType fzf tnoremap <buffer> <leader>q <c-c>
" }

"  esearch{
    call esearch#map('<leader>p', 'esearch')
    let g:esearch = {
      \ 'adapter':    'ag',
      \ 'backend':    'nvim',
      \ 'out':        'win',
      \ 'batch_size': 1000,
      \ 'use':        ['visual', 'hlsearch', 'last'],
      \}
    call esearch#out#win#map('x', 'split')
    call esearch#out#win#map('v', 'vsplit')
    let g:esearch#adapter#ag#options = '--ignore="*dist*" --ignore=".tags*"'

    fu! EsearchInFiles(argv) abort
      let original = g:esearch#adapter#ag#options
      let g:esearch#adapter#ag#options = input('Search options: ')
      call esearch#init(a:argv)
      let g:esearch#adapter#ag#options = original
    endfu

    " noremap  <silent><leader>ft :<C-u>call EsearchInFiles({})<CR>
    " xnoremap <silent><leader>ft :<C-u>call EsearchInFiles({'visualmode': 1})<CR>

    fu! EsearchInPython(argv) abort
      let original = g:esearch#adapter#ag#options
      let g:esearch#adapter#ag#options = '--py'
      call esearch#init(a:argv)
      let g:esearch#adapter#ag#options = original
    endfu

    " noremap  <silent><leader>fp :<C-u>call EsearchInPython({})<CR>
    " xnoremap <silent><leader>fp :<C-u>call EsearchInPython({'visualmode': 1})<CR>

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

" ctags{
    map <A-u> :CtagsUpdate <CR>
" }

" vim-pythonsence{
   let g:is_pythonsense_suppress_motion_keymaps = 1
"}

let g:airline#extensions#coc#enabled = 1

" Commands
" Show available django urls in project(without admin urls)
command! Mpu execute ":tabe | 0read ! python manage.py show_urls | grep -v 'admin'"
" Update ctags from fzf command
command! CtagsUpdate call system(get(g:, 'fzf_tags_command')) | echo "tags updated"
" Reload vimrc
command! ReloadVimrc execute ":so $MYVIMRC | echo 'init.vim reloaded'"

" Cocnvim

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>fo  <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>fc  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-x> <Plug>(coc-range-select)
xmap <silent> <C-x> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" 
