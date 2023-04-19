" Disable automatic formatting of text
setlocal formatoptions-=t
" Disable automatic formatting of comments
setlocal formatoptions-=c
" Remove comment leaders when joining comment lines
setlocal formatoptions+=j
" Set the comment leader to be //
setlocal commentstring=//\ %s
" Continuation of multiline comments
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/
" Disable continuation of single-line comments
setlocal comments-=:// comments+=f://
" Do not indent inside namespace block
setlocal cino=N-s
