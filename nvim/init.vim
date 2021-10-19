"-------------------------------------------------------------------------------
" Set runtimepath
"-------------------------------------------------------------------------------
set rtp+=~/.vim/my-snippets/
set rtp+=/usr/local/opt/fzf

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
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0770)
endif

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set cursorline
set colorcolumn=100
set foldmethod=marker
set hlsearch
set incsearch
set laststatus=2
set mouse=a
set noerrorbells
set noeb vb t_vb=
set noshowmode
set noswapfile
set nowrap
set number
set relativenumber
set scrolloff=8
set smartcase
set smartindent
set splitright
set splitbelow
set undodir=~/.vim/undo
set undofile
" set wildmenu                            " Better menu with completion in command mode
" set wildmode=longest:full,full

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Colorschemes
Plug 'pcheng17/gruvbox', { 'branch': 'PeterWork' }
Plug 'pcheng17/nord-vim', { 'branch': 'stable' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'bfrg/vim-cpp-modern'
Plug 'qpkorr/vim-bufkill'
Plug 'terryma/vim-multiple-cursors'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'mhinz/vim-grepper'
Plug 'rking/ag.vim'
Plug 'airblade/vim-rooter'
Plug 'xolox/vim-misc'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'lervag/vimtex'
Plug 'stephpy/vim-yaml'

call plug#end()

"-------------------------------------------------------------------------------
" Aesthetics
"-------------------------------------------------------------------------------
" Only set termguicolors if not on Mac
if (has("termguicolors"))
    set termguicolors
end

" set background=dark
" let g:gruvbox_italic=0
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_invert_selection='0'
" silent colorscheme gruvbox

silent colorscheme nord

" Indent lines for Yggdroot/indentLine
let g:indentLine_char = '|'

" gruvbox related settings
" nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
" nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
" nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
" nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" Airline settings
let g:airline_theme = 'nord'
let g:airline_section_warning = ''
let g:airline_section_error = ''

" Disable automatic comment continuation
augroup MyFormatOptions
    autocmd!
    autocmd BufNewFile,BufRead,FileType * set formatoptions-=tcro
augroup end

" Remove all trailing whitespace
function! <SID>TrimWhitespace()
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
    " Use ag in CtrlP for listing files
    " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that CtrlP doesn't need to cache
    " let g:ctrlp_use_cache
endif

"-------------------------------------------------------------------------------
" C++ configurations
"-------------------------------------------------------------------------------
augroup cpp_config
	autocmd!
    " Set the comment string to be //
    autocmd FileType,BufRead,BufNewFile c,cpp setlocal commentstring=//\ %s
    " Continuation of multiline comments
    autocmd FileType,BufRead,BufNewFile c,cpp setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/
    " Disable continuation of single-line comments
    autocmd FileType,BufRead,BufNewFile c,cpp setlocal comments-=:// comments+=f://
augroup END
" Do not indent inside namespace block
set cino=N-s


" Markdown configurations {{{
" augroup md_config
"     autocmd!
"     autocmd FileType,BufRead,BufNewFile markdown let g:indentLine_conceallevel = 0
" augroup END
" }}}
" Python configuration {{{
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
" }}}
" Ultisnips configurations {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}
" vim-easy-align configurations {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
" vim-grepper configurations {{{
nnoremap <leader>gg :Grepper -tool git -noswitch<CR>
nnoremap <leader>* :Grepper -tool git -cword -noprompt -noswitch<CR>
" Search for todo and fixme
command! TODO :Grepper -tool git -noswitch -noprompt -query '\(TODO\|FIXME\)'
" }}}
" vim-rooter configurations {{{
" :Rooter sets the working directory to the git root of the current file
let g:rooter_patterns = ['.git/']
let g:rooter_manual_only = 1
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1
" }}}
" vimtex configurations {{{
" let g:tex_flavor = 'latex'
" let g:vimtex_compiler_progname = 'nvr'
" let g:vimtex_view_method = 'SumatraPDF'
" let g:vimtex_compiler_latexmk = {
"     \ 'build_dir' : '',
"     \ 'callback' : 1,
"     \ 'continuous' : 1,
"     \ 'executable' : 'latexmk',
"     \}
"set conceallevel=1
"let g:tex_conceal = 'abdmg'
" }}}
" fzf configurations {{{
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <leader><space> :GFiles<CR>
nnoremap <leader>; :Buffers<CR>
" }}}

"-------------------------------------------------------------------------------
" Load other specific settings
"-------------------------------------------------------------------------------
source ~/vim-config/a.vim

"-------------------------------------------------------------------------------
" Mappings
"-------------------------------------------------------------------------------
nmap <leader>fs :update<CR>
nmap <leader>qq :q<CR>
nmap <leader>fq :q!<CR>
noremap J 10j
noremap K 10k
nnoremap <C-k> :cprev<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <leader>re :e!<CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap ++ :vertical resize +5<CR>
nnoremap -- :vertical resize -5<CR>

" Best remap ever
" Paste, but delete to the black hole register
xnoremap <leader>p "_dP

" Append next line to current line with a space, and move cursor back
nnoremap J mzJ`z

" Easier indentation
vnoremap < <gv
vnoremap > >gv

" Easier comments
nmap <leader>/ gcc
vmap <leader>/ gc

" Copy to clipboard
" nnoremap <leader>yy "+yy
" nnoremap <leader>y$ "+y$
" vnoremap <leader>y "+y

" Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P

" Iterative word replace via .
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

" Repeat last macro used
nnoremap Q @@

" Execute the current line as if it's a command
nnoremap <leader>e :exe getline(line('.'))<CR>

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
