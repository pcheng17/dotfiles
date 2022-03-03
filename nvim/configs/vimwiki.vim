" When managing more than one wiki, you can create a dictionary containing default
" wiki settings to then copy off of to create the actualy wiki dictionaries.
let wikiDefault = {}
let wikiDefault.syntax = 'markdown'
let wikiDefault.ext = '.md'
let wikiDefault.diary_rel_path = 'journal/'
let wikiDefault.diary_index = 'journal'
let wikiDefault.diary_header = 'Journal'
" let wikiDefault.links_space_char = '-'
let wikiDefault.auto_diary_index = 1
" let wikiDefault.auto_tags = 1

let wikiPers = copy(wikiDefault)
let wikiPers.name = 'MyWiki'
if has('wsl')
    let wikiPers.path = '/mnt/d/Peter/Documents/Workspace/wiki/'
elseif g:os == 'Darwin'
    let wikiPers.path = '~/Workspace/wiki/'
endif

let wikiCafeQED = copy(wikiDefault)
let wikiCafeQED.name = 'CafeQED'
if has('wsl')
    let wikiCafeQED.path = '/mnt/d/Peter/Documents/Workspace/cafeqed/'
elseif g:os == 'Darwin'
    let wikiCafeQED.path = '~/Workspace/cafeqed'
endif

let g:vimwiki_list = [wikiPers, wikiCafeQED]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_conceal_onechar_markers = 0
let g:vimwiki_hl_headers = 1

command! -bang -nargs=* WikiRg call fzf#vim#grep('rg
      \ --column --line-number --no-heading --color=never
      \ --smart-case --type md <q-args> ',
      \ 1, fzf#vim#with_preview(), <bang>0)

augroup VimwikiConfig
    autocmd!
    autocmd BufNewFile /mnt/d/Peter/Documents/Workspace/wiki/*.md
        \ silent! 0r !~/.vim/bin/load-vimwiki-frontmatter.py '%'
    autocmd BufNewFile /mnt/d/Peter/Documents/Workspace/cafeqed/*.md
        \ silent! 0r !~/.vim/bin/load-vimwiki-frontmatter.py '%'
augroup end
