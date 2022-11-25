setlocal textwidth=80
setlocal wrap
setlocal linebreak

noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'
