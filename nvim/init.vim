"-------------------------------------------------------------------------------
" Detect operating system
"-------------------------------------------------------------------------------
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

"-------------------------------------------------------------------------------
" Set runtimepath
"-------------------------------------------------------------------------------
set rtp+=$HOME/.vim
set rtp+=$HOME/.vim/after

"-------------------------------------------------------------------------------
" Set leader key
"-------------------------------------------------------------------------------
let mapleader="\<SPACE>"
nnoremap <Space> <nop>

"-------------------------------------------------------------------------------
" Basic settings
"-------------------------------------------------------------------------------

" Create undo directory
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0700)
endif
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "", 0700)
endif

filetype plugin on

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set clipboard+=unnamedplus
set cursorline
set colorcolumn=100
set completeopt=menu,menuone,noselect
set hlsearch
set iskeyword-=.
set incsearch
set inccommand=nosplit
set laststatus=2
set mouse=a
set noerrorbells
set noeb vb t_vb=
set noshowmode
set noswapfile
set nowrap
set number
set relativenumber
set scrolloff=5
set scroll=10
set smartcase
set smartindent
set splitright
set splitbelow
set undodir=~/.vim/undodir
set undofile
set wildmenu
set wildmode=longest:full,full

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" ------------------------------------------------------------------------------
" Colorschemes
" ------------------------------------------------------------------------------
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'pcheng17/gruvbox', { 'branch': 'PeterWork' }
" Plug 'pcheng17/nord-vim', { 'branch': 'stable' }

" ------------------------------------------------------------------------------
" Status line for vim
" ------------------------------------------------------------------------------
Plug 'vim-airline/vim-airline'

if has('nvim')
    Plug 'lukas-reineke/indent-blankline.nvim'
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'williamboman/nvim-lsp-installer'
    " Plug 'hrsh7th/nvim-cmp'
    " Plug 'hrsh7th/cmp-nvim-lsp'
    " Plug 'hrsh7th/cmp-buffer'
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    Plug 'nvim-lua/plenary.nvim' " Requried by telescope.nvim
    Plug 'nvim-telescope/telescope.nvim'
else
    Plug 'Yggdroot/indentLine'
    Plug 'sheerun/vim-polyglot'
    plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    plug 'junegunn/fzf.vim'
endif

Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-grepper'
Plug 'rking/ag.vim'
Plug 'airblade/vim-rooter'
Plug 'lervag/vimtex'

" ------------------------------------------------------------------------------
" Snippets
" ------------------------------------------------------------------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()


if has('nvim')
    " luafile ~/.config/nvim/lua/nvim-cmp_config.lua
    " luafile ~/.config/nvim/lua/lsp_config.lua
    luafile ~/.config/nvim/lua/treesitter_config.lua
end

if g:os == "Darwin"
    let g:python3_host_prog = '~/.virtualenvs/neovim/bin/python'
endif

"-------------------------------------------------------------------------------
" Airline
"-------------------------------------------------------------------------------
let g:airline_section_z = airline#section#create_right(['%p%% %l:%c'])

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Unicode symbols - see `:h airline-customization` for others
let g:airline_symbols.branch = ''

"-------------------------------------------------------------------------------
" Aesthetics
"-------------------------------------------------------------------------------
" Only set termguicolors if not on Mac
if (has("termguicolors"))
    set termguicolors
end

let g:dracula_italic = 0
silent colorscheme dracula

"-------------------------------------------------------------------------------
" Remove all trailing whitespace
"-------------------------------------------------------------------------------
function! <SID>TrimWhitespace()
    if &ft =~ 'markdown'
        return
    endif
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup TrimWhitespace
    autocmd!
    autocmd BufWritePre * :call <SID>TrimWhitespace()
augroup end

" ag searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ --column
endif

" Python configuration
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0

"-------------------------------------------------------------------------------
" UltiSnips configurations
"-------------------------------------------------------------------------------
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]
let g:UltiSnipsListSnippets='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" vim-grepper configurations
nnoremap <Leader>gg :Grepper -tool git -noswitch<CR>
nnoremap <Leader>* :Grepper -tool git -cword -noprompt -noswitch<CR>
" Search for todo and fixme
command! TODO :Grepper -tool git -noswitch -noprompt -query '\(TODO\|FIXME\)'

" vim-rooter configurations
" :Rooter sets the working directory to the git root of the current file
let g:rooter_patterns = ['.git/']
let g:rooter_manual_only = 1
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" vimtex configurations
let g:tex_flavor = 'latex'
" let g:vimtex_compiler_progname = 'nvr'
" let g:vimtex_view_method = 'SumatraPDF'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \}

" fzf configurations
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }


"-------------------------------------------------------------------------------
" Mappings
"-------------------------------------------------------------------------------
noremap J 10j
noremap K 10k

nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
" The following seems to do funny things in WSL2
" nnoremap <Leader>sv :source $MYVIMRC<CR>

nmap <Leader>fs :update<CR>
nmap <Leader>qq :q<CR>
nmap <Leader>fq :q!<CR>

" nnoremap <C-k> :cprev<CR>
" nnoremap <C-j> :cnext<CR>
nnoremap <Leader>re :e!<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader><CR> :so ~/.vimrc<CR>
nnoremap ++ :vertical resize +5<CR>
nnoremap -- :vertical resize -5<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Moving text
" nnoremap <Leader>j :m .+1<CR>==
" nnoremap <Leader>k :m .-2<CR>==
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv
" inoremap <C-j> <C-o>:m .+1<CR>==
" inoremap <C-k> <C-o>:m .-2<CR>==

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Best remap ever
" Paste, but delete to the black hole register
xnoremap <Leader>p "_dP

" Yank until end of line
nnoremap Y y$

" Append next line to current line with a space, but don't move cursor
nnoremap U mzJ`z
vnoremap U mzJ`z

" Jump to next or previous result, center line, open folds
nnoremap n nzzzv
nnoremap N Nzzzv

" Insert undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Easier indentation
vnoremap < <gv
vnoremap > >gv

" Easier comments
nmap <Leader>/ gcc
vmap <Leader>/ gc

" Copy to clipboard
" nnoremap <Leader>yy "+yy
" nnoremap <Leader>y$ "+y$
" vnoremap <Leader>y "+y

" Paste from clipboard
" nnoremap <Leader>p "+p
" nnoremap <Leader>P "+P
" vnoremap <Leader>p "+p
" vnoremap <Leader>P "+P

" Iterative word replace via .
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

" Repeat last macro used
nnoremap Q @@

if has('nvim')
    nnoremap <leader><space> <cmd>Telescope find_files<CR>
    nnoremap <leader>; <cmd>Telescope buffers<CR>
    nnoremap <leader>gr <cmd>Telescope live_grep<CR>
else
    nnoremap <leader><space> :GFiles<CR>
    nnoremap <leader>; :Buffers<CR>
endif

"-------------------------------------------------------------------------------
" Source other files
"-------------------------------------------------------------------------------
source $HOME/.dotfiles/nvim/a.vim

"-------------------------------------------------------------------------------
" Autoload files that have changed in neovim
" Thanks to https://github.com/neovim/neovim/issues/2127
"-------------------------------------------------------------------------------
augroup AutoSwap
    autocmd!
    autocmd SwapExists * call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
    " if swapfile is older than file itself, just get rid of it
    if getftime(v:swapname) < getftime(a:filename)
            call delete(v:swapname)
            let v:swapchoice = 'e'
    endif
endfunction
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END
