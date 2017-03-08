" stumble.vim - Create transactional registration files for Balans
" Maintainer:   Petter Rodhelind <https://vargklippan.se>
" License:      This file is placed in the public domain.
" Version:      1.0
"
if exists("g:loaded_stumble")
	finish
endif
let g:loaded_stumble = 1

" Global variables, intended to be changed in user's .vimrc
let g:stumble_user = ""

function! s:trim(str) abort
    let str = a:str
    let str = substitute(str,'^\s*','','')
    let str = substitute(str,'\s*$','','')
    return str
endfunction

function! s:parseline(str) abort
    if empty(a:str) || match(a:str, '^\*') != -1
        return ""
    elseif match(a:str, '^--') != -1
        return a:str
    endif

    let l:fields = split(a:str, ';')
    if len(l:fields) < 5
        return "--PARSE ERROR: " . a:str
    endif

    let l:date = s:trim(l:fields[0])
    let l:project = s:trim(l:fields[1])
    let l:activity = s:trim(l:fields[2])
    let l:time_int = s:trim(l:fields[3])
    let l:time_ext = s:trim(l:fields[4])
    if len(l:fields) >= 6
        let l:comment = s:trim(l:fields[5])
    else
        let l:comment = ""
    endif

    if empty(l:time_ext)
        let l:time_ext = 0
    endif

    let l:str = g:stumble_user . ";" .
        \ l:project . ";;" .
        \ repeat(l:date . ";", 3).
        \ l:activity . ";" .
        \ l:time_int . ";" . l:time_ext . ";" .
        \ l:comment . ";" . l:comment . ";" .
        \ "1;;;;;;;"

    return l:str
endfunction

" The magic
function! s:stumble(type,...) abort
    if a:0
        let [l1, l2] = [a:type, a:1]
    else
        let [l1, l2] = [line("'["), line("']")]
    endif

	let l:date = strftime("%Y%m%d%H%M%S")
    let l:rows = ["-- Generated by vim-stumble"]
    if empty(g:stumble_user)
        call inputsave()
        let g:stumble_user = input("Username: ")
        call inputrestore()
    endif

    " parse each line in selection and add to output
    for lnum in range(l1,l2)
        let l:row = s:parseline(getline(lnum))
        if !empty(l:row)
            call add(l:rows, l:row)
        endif
    endfor

    " new split buffer, latin1-enc and DOS newline
    execute "sp " . l:date . ".balans"
    setlocal encoding=utf-8
    setlocal fileencoding=latin1
	setlocal fileformat=dos

    " append entries into the new buffer
    call setline(".", l:rows)
endfunction

" Bind a command
if !exists(":Stumble")
	command! -range Stumble call <SID>stumble(<line1>,<line2>)
endif
