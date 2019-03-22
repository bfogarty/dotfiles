" Plugins
call plug#begin()

" Util
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" UI
Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'

" Code
Plug 'davidhalter/jedi-vim'
Plug 'w0rp/ale'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'

" Writing
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim',  { 'on': 'Limelight' }

call plug#end()

" Mappings

let mapleader = ","

nmap ; :Files<CR>
nmap <leader>b :Buffers<CR>

nmap <C-\> :NERDTreeToggle<CR>

nmap <silent> <leader>l <Plug>DashSearch
nmap <leader>t :term<CR>

nmap <leader>w :Goyo<CR>

nmap <leader>gc :Gcommit<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gp :Gpush<CR>

nmap <leader><C-f> :Rg<CR>

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>

" Config
let macvim_skip_colorscheme = 1

let g:nord_comment_brightness = 12

let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }

let g:ale_fixers = {
            \   'python': ['black', 'isort'] }

let g:ale_fix_on_save = 1

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

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#custom_strategies = {'persist': function('PersistStrategy')}
let g:test#strategy = 'persist'

set formatoptions-=cro " stop comments on newlines
set hidden             " allow hidden buffers
set fillchars+=vert:\  " set vert divider character to <space>
set backspace=2        " backspace across lines
set number             " line numbers
set noshowmode         " lightline shows the mode
set linebreak          " wrap on newline only, for notes
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set guioptions=        " hide scrollbars
set guifont=Monaco:h14

" Color scheme
colorscheme nord

" Auto-reload ~/.vimrc
augroup vimrc-reload
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" Enable limelight for distraction-free writing
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Custom commands
command! PrettyJson %!python -m json.tool
" custom definition of Rg to add --trim
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --trim --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0)

" Enable project specific .vimrc files
set exrc
set secure
