" Copy markdown settings
setlocal formatoptions-=t
setlocal textwidth=100
setlocal wrap
setlocal linebreak

noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'

function! VimwikiTabOrUltiSnips() abort
    let ret = vimwiki#tbl#kbd_tab()
    if ret == "\<Tab>"
        return "\<C-R>=UltiSnips#ExpandSnippetOrJump()\<CR>"
    end
    return ret
endfunction

function! VimwikiShiftTabOrSupertab() abort
    let ret = vimwiki#tbl#kbd_shift_tab()
    if ret == "\<S-Tab>"
        return "\<C-R>=SuperTab('p')\<CR>"
    end
    return ret
endfunction

inoremap <silent><expr><buffer> <TAB> VimwikiTabOrUltiSnips()
inoremap <silent><expr><buffer> <S-TAB> VimwikiShiftTabOrSupertab()

nnoremap <leader>wf :WikiRg<Space>
nnoremap <leader>wt :VimwikiSearchTags<Space>
