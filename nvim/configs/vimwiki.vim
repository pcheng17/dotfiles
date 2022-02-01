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
let g:vimwiki_auto_header = 1
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_conceal_onechar_markers = 0
let g:vimwiki_hl_headers = 1

function! vimwiki#fzf()
    let l:root = g:vimwiki_list[0].path
    let l:extension = g:vimwiki_list[0].ext
    let l:pages = globpath(l:root, '**/*' . l:extension, v:true, v:true)
    let l:opts = '--print-query --prompt "VimWiki> "'
    call fzf#run(fzf#wrap({
        \ 'source': l:pages,
        \ 'sink': 'e',
        \ 'options': l:opts
        \ }))
endfunction
