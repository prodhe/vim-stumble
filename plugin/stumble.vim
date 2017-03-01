" stumble.vim - Create transactional registration files for Balans
" Maintainer:   Petter Rodhelind <https://vargklippan.se>
" License:      This file is placed in the public domain.
" Version:      0.9
"
if exists("g:loaded_stumble")
	finish
endif
let g:loaded_stumble = 1

" Global variables, intended to be changed in user's .vimrc
let g:stumble_user = "ABCXYZ"
let g:stumble_projects = {'':''}
let g:stumble_activities = {'':''}

" The magic
function! s:stumble() abort
	let l:date = repeat(strftime("%Y-%m-%d") . ";", 3)
	let l:fields = split(getline("."), '\t')

	if len(l:fields) < 4
		echoerr "Syntax error: need at least 4 <TAB> separated entries"
		return 0
	endif

	let l:project = l:fields[0]
	let l:activity = l:fields[1]
	let l:time = l:fields[2]
	let l:comment = l:fields[3]

	let l:str = g:stumble_user . ";;" .
		\ l:project . ";" .
		\ l:date .
		\ l:activity . ";" .
		\ l:time . ";" . l:time . ";" .
		\ l:comment . ";" . l:comment . ";" .
		\ "1;;;;;"

	call setline(".", l:str)
	setlocal fileformat=dos " required by Balans
endfunction

" Bind a command
if !exists(":Stumble")
	command! Stumble call <SID>stumble()
endif
