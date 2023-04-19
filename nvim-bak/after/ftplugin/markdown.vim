setlocal formatoptions-=t
setlocal textwidth=100
setlocal wrap
setlocal linebreak

noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'
