" When managing more than one wiki, you can create a dictionary containing default
" wiki settings to then copy off of to create the actualy wiki dictionaries.
let wikiDefault = {}
let wikiDefault.syntax = 'markdown'
let wikiDefault.ext = '.md'

" let myRealWiki = copy(wikiDefault)

let wikiPers = {}
let wikiPers.name = 'MyWiki'
let wikiPers.path = '/mnt/d/Peter/Documents/Workspace/wiki/'
let wikiPers.syntax = 'markdown'
let wikiPers.ext = '.md'
let wikiPers.index = 'inbox'
let wikiPers.diary_rel_path = 'journal/'
let wikiPers.diary_index = 'journal'
let wikiPers.diary_header = 'Journal'
let wikiPers.links_space_char = '_'
let wikiPers.auto_diary_index = 1
let wikiPers.auto_tags = 1

let g:vimwiki_list = [wikiPers]
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_conceal_onechar_markers = 0
let g:vimwiki_hl_headers = 1

augroup VimwikiConfig
    autocmd!
    autocmd BufNewFile /mnt/d/Peter/Documents/Workspace/wiki/*.md
        \ silent! 0r !~/.vim/bin/load-vimwiki-frontmatter.py '%'
augroup end
