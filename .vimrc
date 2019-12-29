" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

" Util
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'embear/vim-localvimrc'

" UI
Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'

" Code
Plug 'davidhalter/jedi-vim'
Plug 'w0rp/ale'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'chaoren/vim-wordmotion'
Plug 'posva/vim-vue', { 'for': 'vuejs' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'vuejs'] }

" Writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim',  { 'on': 'Limelight' }

call plug#end()

" Mappings

let mapleader = ","

noremap <silent> j gj
noremap <silent> k gk

noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>

nmap <leader>b :Buffers<CR>

nmap <C-\> :NERDTreeToggle<CR>

nmap <silent> <leader>l <Plug>DashSearch
" TODO toggle these lines for nvim support:
nmap <leader>t :bel term<CR>
" nmap <leader>t :sp +term<CR>

nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>

nmap <leader>gc :Gcommit<CR>
nmap <leader>gs :Gstatus<CR><C-w>L
nmap <leader>gp :Gpush<CR>
nmap <leader>gb :Gbranch<CR>

nmap <leader>p :Project<CR>

nmap <leader>f :Files<CR>
nmap <leader><C-t> :Tags<CR>
nmap <leader><C-f> :Rg<CR>

" Quick resizing for terminal
tnoremap <leader>1 <C-w>:res 10<CR>
tnoremap <leader>2 <C-w>:res 20<CR>

" alt + arrow support for terminal
tnoremap <silent> <M-left> <Esc><Left>
tnoremap <silent> <M-right> <Esc><Right>
tnoremap <silent> <M-BS> <Esc><BS>

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>

" TODO workaround for the following bug:
"   https://github.com/vim/vim/issues/4738
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>

" Config
let macvim_skip_colorscheme = 1

let g:lightline = {
\   'colorscheme': 'nord',
\   'active': {
\       'left': [
\           [ 'mode', 'paste' ],
\           [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
\       ],
\       'right': [ [ 'lineinfo' ], [ 'project' ] ]
\   },
\   'component_function': {
\       'project': 'CurrentProject',
\       'gitbranch': 'fugitive#head',
\   },
\ }

function! CurrentProject()
    " the current directory, relative to ~/dev/
    return fnamemodify(getcwd(), ':~:s?\~\/dev\/??')
endfunction

let g:ale_linters = {
\   'python': ['flake8'],
\}

let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'javascript': ['prettier'],
\   'go': ['goimports']
\ }

let g:ale_fix_on_save = 1
let g:ale_pattern_options = {
\   '.*migrations/.*\.py$': {'ale_fix_on_save': 0},
\}
let g:ale_python_auto_pipenv = 1
let g:ale_python_black_change_directory = 0
let g:ale_python_flake8_change_directory = 0
let g:ale_python_isort_change_directory = 0

let g:localvimrc_whitelist = ['~/dev/[^/]\+/.lvimrc']

let g:vue_pre_processors = []

function! DockerTransform(cmd)
    return 'docker-compose run --service-ports test '.a:cmd
endfunction

function! PersistStrategy(cmd)
    if !exists("g:test#vimterminal_buffer") || !bufexists(g:test#vimterminal_buffer)
        belowright 20 new
        let g:test#vimterminal_buffer =
            \ term_start(&shell, {'term_finish': 'close', 'curwin': 1})
        wincmd p
    endif

    call term_sendkeys(g:test#vimterminal_buffer, a:cmd . "\<CR>")
endfunction

function! LightlineReload()
    " Calling these three functions will reload lightline:
    " https://github.com/itchyny/lightline.vim/issues/241
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! WipeoutHiddenBuffers()
    " modified from: https://stackoverflow.com/a/7321131

    " from :help tabpagebuflist, gets a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    " below originally inspired by Hara Krishna Dara and Keith Roberts
    " http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        " bufno exists, isn't modified, and is hidden
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

function! s:ChangeBranch(branch)
    execute 'Git checkout ' . a:branch
    " TODO disabled until node_modules is excluded properly
    " execute '!ctags -R .'
endfunction

function! s:ChangeProject(project)
    execute 'lcd ~/dev/' . a:project
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#custom_strategies = {'persist': function('PersistStrategy')}
let g:test#strategy = 'persist'

let g:livepreview_previewer = 'open -a Preview'

set formatoptions-=cro " stop comments on newlines
set fillchars+=vert:\  " set vert divider character to <space>
set backspace=2        " backspace across lines
set number             " line numbers
set noshowmode         " lightline shows the mode
set linebreak          " wrap on newline only, for notes
set laststatus=2       " always show a status line
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set noequalalways      " prevent splits from auto-resizing
set ignorecase
set incsearch

set guioptions=a        " hide scrollbars, use copy-on-select

" TODO disable the following for nvim support:
" this should likely be moved to a .gvimrc?
set guifont=Source\ Code\ Pro\ 12

" Color scheme
colorscheme nord

" Hide ~ at end of buffer by setting to bg color
" highlight EndOfBuffer ctermfg=bg guifg=bg

" Auto-reload ~/.vimrc
augroup vimrc-reload
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" Highlight the current line
augroup CurBufferHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" Enable limelight for distraction-free writing
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set nonumber in terminal buffers to prevent bad line wrapping
" disable the following for nvim support:
autocmd! TerminalOpen * setlocal nonumber

" Preemptively rehighlight .vue files
autocmd! FileType vuejs syntax sync fromstart

" Custom commands
command! LightlineReload call LightlineReload()
command! WipeoutHiddenBuffers call WipeoutHiddenBuffers()
command! PrettyJson %!python -m json.tool
command! -nargs=1 DiffBranch rightbel vsp | exec ":Gedit " . <q-args> . ":" . @%

command! -bang Project call fzf#run({
            \ 'source': 'ls -d ~/dev/*/ | xargs -n 1 basename',
            \ 'sink': function('s:ChangeProject'),
            \ 'options': ['--prompt', 'Project> '],
            \ 'right': 30
            \ })

" from: https://vi.stackexchange.com/a/15991
command! -bang Gbranch call fzf#run({
            \ 'source': 'git for-each-ref --format="%(refname:short)" refs/heads',
            \ 'sink': function('s:ChangeBranch'),
            \ 'options': ['--prompt', 'Branch> '],
            \ 'down': '~40%'
            \ })
