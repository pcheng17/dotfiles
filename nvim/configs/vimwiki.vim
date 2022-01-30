let wikiPers = {}
let wikiPers.path = '/mnt/d/Peter/Documents/Workspace/wiki'
let wikiPers.syntax = 'markdown'
let wikiPers.ext = '.md'
let wikiPers.links_space_char = '_'
let wikiPers.diary_rel_path = 'journal/'
let wikiPers.diary_index = 'journal'
let wikiPers.diary_header = 'Journal'
let wikiPers.auto_tags = 1

let g:vimwiki_list = [wikiPers]
let g:vimwiki_global_ext = 0
let g:vimwiki_auto_header = 1
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_conceal_onechar_markers = 0

augroup VimwikiConfig
    autocmd!
    " Automatically update links on read
    autocmd BufNewFile,BufRead diary.md VimwikiDiaryGenerateLinks
augroup end
