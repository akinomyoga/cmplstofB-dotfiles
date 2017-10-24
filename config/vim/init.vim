scriptencoding utf-8

" 基礎
let $MYVIMDIR = expand("<sfile>:p:h")
let $MYVIMCONFDIR = expand($MYVIMDIR) . "/rc"
let $MYVIMDATADIR = expand($XDG_DATA_HOME) . "/vim"

" Include 函數
function! s:Include(sourcefilename)
	let l:sourcefilepath = expand($MYVIMDIR) . "/" . expand(a:sourcefilename) . ".vim"
	if filereadable(expand(l:sourcefilepath))
		execute 'source' l:sourcefilepath
	else
		return "No such file or directory"
	endif
endfunction

" 読み込み
" 基本的な挙動
call s:Include("rc/pref")
" 電鍵その他の操作
call s:Include("rc/input")
" 外見
call s:Include("rc/appearance")
" 外部拡張
call s:Include("rc/usrex")

" 起動
"function! s:GetBufByte()
"	let _byte = line2byte(line('$') + 1)
"	if _byte == -1
"		return 0
"	else
"		return byte - 1
"	endif
"endfunction
"autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | oldfiles | endif

