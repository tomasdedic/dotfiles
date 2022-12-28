" ========================================================================///
" Description: import UltiSnips snippets as VsCode snippets for vim-vsnip
" File:        import.vim
" Author:      Gianmaria Bajo <mg1979@git.gmail.com>
" License:     MIT
" Created:     dom 09 agosto 2020 13:14:35
" Modified:    dom 09 agosto 2020 15:33:32
" ========================================================================///

function! import#snippets(ask_confirm) abort
  if expand('%:e') !=# 'snippets'
    echo '[vsnip] not a snippets file'
    return
  elseif !search('^endsnippet$')
    echo '[vsnip] not an UltiSnips snippets file'
    return
  endif
  1
  let snips = {}
  while search('^snippet\s\+.*".*".*', 'cW')
    try
      let matches = matchlist(getline('.'), '^snippet\s\+\([^" \t]\+\)\s\+"\(.*\)"')[1:2]
      if empty(matches)
        break
      endif
      let [name, description] = matches
      let snip = {}
      let snips[name] = snip
      let snip.prefix = [name]
      let snip.description = description
      let [start, end] = [line('.') + 1, search('^endsnippet$', 'n') - 1]
      let snip.body = s:correct_body(getline(start, end))
      normal! j
    catch
      echo '[vsnip] error while parsing file'
      return
    endtry
  endwhile
  if empty(snips)
    echo '[vsnip] no snippets have been imported'
    return
  endif
  if expand('%:t') == 'all.snippets'
    set ft=
    VsnipOpenSplit
  else
    exe 'setf' expand('%:t:r')
    VsnipOpenSplit!
  endif
  wincmd p
  set ft=
  wincmd p
  if filereadable(@%)
    silent %y
    let current_snips = json_decode(@")
  else
    let current_snips = {}
  endif
  let added = 0
  for sn in keys(snips)
    if a:ask_confirm
      if has_key(current_snips, sn)
        if !s:confirm_replace_snippet(current_snips[sn], snips[sn])
          continue
        endif
      elseif !s:confirm_add_snippet(snips[sn])
        continue
      endif
    endif
    let current_snips[sn] = snips[sn]
    let added += 1
  endfor
  redraw
  if added
      %d _
      call setline(1, json_encode(current_snips))
      if executable('python3')
        %!python3 -m json.tool
      elseif executable('python')
        %!python -m json.tool
      endif
      echo '[vsnip] added' added 'snippets'
    else
      echo '[vsnip] no changes'
  endif
endfunction

fun! s:correct_body(lines) abort
  let i = 0
  for line in a:lines
    let a:lines[i] = substitute(a:lines[i], '\${VISUAL}', '$TM_SELECTED_TEXT', 'g')
    let i += 1
  endfor
  return a:lines
endfun

fun! s:confirm_add_snippet(snip) abort
  redraw
  echohl Title
  echo 'Add this snippet? (y/n)'
  echo "\n"
  echohl None
  echo string(a:snip)
  echo "\n"
  return nr2char(getchar()) == 'y'
endfun

fun! s:confirm_replace_snippet(current, snip) abort
  redraw
  echohl WarningMsg
  echo "Replace this snippet:"
  echo "\n"
  echohl None
  echo string(a:current)
  echo "\n"
  echohl WarningMsg
  echo 'with this snippet? (y/n)'
  echo "\n"
  echohl None
  echo string(a:snip)
  echo "\n"
  return nr2char(getchar()) == 'y'
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: et sw=2 ts=2 sts=2 fdm=marker
