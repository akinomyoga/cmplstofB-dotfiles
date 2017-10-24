scriptencoding utf-8

" ノーマルモード {{{1

" `C`, `D` に挙動を合わせる
nnoremap Y y$

" `u` -- `U` という対応にする
nnoremap U <C-r>
nnoremap <C-r> U

" 前置鍵盤
nnoremap <space> <Nop>
nnoremap <S-space> <Nop>
let mapleader = "\<space>"
let maplocalleader = "\<S-space>"

" 行の真ん中に移動
nnoremap gm :call<space>cursor(0,<space>strlen(getline("."))/2)<CR>

" タブ移動
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT

" 検索語句解除/File 種別再認識/画面再描写
nnoremap <silent> <C-l> :<C-u>nohlsearch<bar>filetype<space>detect<bar>redraw!<CR>

" 行の移動で視覚的に違和感を感じないように {{{2
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk
onoremap <silent> j gj
onoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k
xnoremap <silent> gj j
xnoremap <silent> gk k
onoremap <silent> gj j
onoremap <silent> gk k
" }}}2

" 文字列の置換で視覚的に違和感を感じないように {{{2
nnoremap <silent> r gr
nnoremap <silent> R gR
nnoremap <silent> gr r
nnoremap <silent> gR R
" }}}2

" 検索・置換 {{{2
" 文書全体の置換
nnoremap g: :<C-u>%substitute//g<Left><Left>
" `&` 
nnoremap & :&&<CR>
xnoremap & :&&<CR>
" 選択範囲で検索 標準 `*` 及び `#` 上書き
xnoremap * :<C-u>call<space><SID>s:VisualSelectedSearch()<CR>/<C-r>=@/<CR><CR>
xnoremap # :<C-u>call<space><SID>s:VisualSelectedSearch()<CR>?<C-r>=@/<CR><CR>
function! s:VisualSelectedSearch()
	let _tmp = @s
	normal! gv"sy
	let @/ = "\\V" . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = _tmp
endfunction
" }}}2

" 手引き {{{2
" TODO:  FileType Plugin にして起動の高速化を図る
nnoremap <C-h> :<C-u>help<space>
" 文書の種類に合わせた手引き
setglobal keywordprg=
augroup FileTypeHelp
	autocmd!
	autocmd FileType vim,help setlocal keywordprg=:help
	autocmd FileType sh,man setlocal keywordprg=:man
augroup END
" Man.vim
augroup ManVimConfig
	autocmd!
	autocmd FileType man setlocal nolist | setlocal nonumber
augroup END
" TODO: 任意の範囲を指定可能な手引き
" 手引き頁にて q で閉じる
augroup HelpWindowQKeyClose
	autocmd!
	autocmd FileType help nnoremap <buffer> q :helpclose<CR>
augroup END
" }}}2

" Quickfix で素早く移動
" TODO: やめるかも。挙動不審。
"command! -nargs=0 -bar Qargs execute 'args' QuickfixArgs()
"function! QuickfixArgs()
"	let _bn = {}
"	for _qfit in getqflist()
"		let _bn[_qfit['bufnr']] = bufname(_qfit['bufnr'])
"	endfor
"	return join(map
" }}}1

" 命令欄 {{{1

" 命令欄の挙動 (Emacs っぽく)
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-h> <BS>
cnoremap <C-d> <Del>
cnoremap <C-x><C-m> <C-a>
cnoremap <C-x>l <C-d>
cnoremap <C-l> <C-f>
cnoremap <space> <C-]><space>

" 命令管理窓を q で閉じる
augroup CmdWindowEscKeyClose
	autocmd!
	autocmd CmdwinEnter * nnoremap <buffer> q <C-c><C-c>
augroup END

" }}}1

" 内部端末 {{{1

" 内部端末を離脱する前置鍵盤
setglobal termkey=<C-g>

" }}}1

" 短縮入力 {{{1

" 通常
abclear

" 命令欄
cabclear
cabbrev vr $
cabbrev hm ~
cabbrev e edit
cabbrev te tabedit
cabbrev sp split
cabbrev vs vsplit

" }}}1

" 命令 {{{1

comclear

" 管理者として保存
" TODO:  確認をすっとばしたい
command! -nargs=0 -complete=file -bang Sw write<bang><space>!\sudo<space>\tee<space>%<space>><space>/dev/null

" }}}1

" TODO: 以下は mattn 氏かが 2ch に書き込んでいた Vim Script だが解読不能。便利そうなので保留 {{{1
" なお注釈は原文ママ
"" インサートモードに入るか、入力を行った最後の時間を変数に保存
"autocmd! InsertEnter,InsertChange * :let s:last_action_time = localtime()
"autocmd! CursorMovedI * :call s:leave_insert_mode() | let s:last_action_time = localtime()
"autocmd! InsertCharPre * :call s:leave_insert_mode("call feedkeys('" . v:char . "', 'n')", "let v:char = '' ")
"" 最後の入力からこの秒数を超えた時間が経過していればInsertを終了する
"let s:wait_sec = 20
"function! s:leave_insert_mode(...)
"    let s:last_action_time = get(s:, "last_action_time", localtime())
"    let l:elapsed_sec = localtime() - s:last_action_time
"    " 経過時間が指定待ち時間を超えていれば
"    if l:elapsed_sec > s:wait_sec
"        call feedkeys("\<ESC>")
"        " 文字列として指定されたlambda式を実行
"        for action in a:000
"            execute action
"        endfor
"    endif
"endfunction
" }}}1

