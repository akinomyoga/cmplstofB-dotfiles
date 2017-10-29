scriptencoding utf-8

" 編集時 {{{1
" 不可視文字 {{{
if exists('$DISPLAY')
	set list
	set listchars=eol:⏎,tab:>\ ,space:␣
else
	set nolist
endif
" }}}

" 文字幅 {{{
setglobal ambiwidth=single
setglobal emoji
" }}}

" タブ {{{
setglobal showtabline=2
" }}}
" }}}1

" 編集子 {{{
if exists('$DISPLAY')
	if exists('$TMUX')
		let &t_ti = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
		let &t_te = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[5 q\<Esc>\\"
		let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
	elseif &term =~ "screen."
		let &t_ti = "\<Esc>P\<Esc>[2 q\<Esc>\\"
		let &t_te = "\<Esc>P\<Esc>[2 q\<Esc>\\"
		let &t_SI = "\<Esc>P\<Esc>[5 q\<Esc>\\"
		let &t_SR = "\<Esc>P\<Esc>[4 q\<Esc>\\"
		let &t_EI = "\<Esc>P\<Esc>[2 q\<Esc>\\"
	else
		let &t_ti = "\<Esc>[2 q"
		let &t_te = "\<Esc>[2 q"
		let &t_SI = "\<Esc>[5 q"
		let &t_SR = "\<Esc>[4 q"
		let &t_EI = "\<Esc>[2 q"
	endif
endif
set number
set relativenumber
set ruler
augroup ShowCursorPosition
	autocmd!
	autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
	autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorcolumn
	autocmd CursorHold,CursorHold,WinLeave * setlocal cursorline
	autocmd CursorHold,CursorHold,WinLeave * setlocal cursorcolumn
augroup END
" }}}

" 構文強調 {{{
set notermguicolors
syntax enable
colorscheme desert
augroup ExpandSyntaxArea
	autocmd!
	autocmd FileType html,xml,php,sh syntax sync minlines=500 maxlines=10000
augroup END
" }}}

" 整形 {{{
setglobal nolinebreak
set formatoptions=tcomMBj
if expand('$LANG') == 'ja_JP.UTF-8'
	set matchpairs=(:),{:},[:],「:」,『:』,【:】,〖:〗,〔:〕,《:》
else
	set matchpairs=(:),{:},[:]
endif
augroup FncJmpMatchChar
	autocmd!
	autocmd FileType c,cpp,java set matchpairs+==:;
augroup END
" }}}

" 綴りの検査 {{{1
" }}}1

" status line {{{
set laststatus=2
set statusline=%F%m%r%h%w%=%v:%l/%L
"" 挿入モード時、ステータスラインの色を変更
"let g:StatusLineInsertHighlight = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"augroup InsertHook
"	autocmd!
"	autocmd InsertEnter * call s:ChangeStatusLineColor('_ins')
"	autocmd InsertEnter * call s:ChangeStatusLineColor('_nrm')
"augroup END
"let s:slhlcmd = ''
"function! s:ChangeStatusLineColor(_mode)
"	if a:_mode == '_ins'
"		silent! let s:_slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"		silent exec g:StatusLineInsertHighlight
"	else
"		highlight clear StatusLine
"		silent exec s:_slhlcmd
"	endif
"endfunction
"function! s:GetHighlight(_hi)
"	redir => _hl
"	exec 'highlight ' . a:_hi
"	redir END
"	let _hl = substitute(_hl, '[\r\n]', '', 'g')
"	let _hl = substitute(_hl, 'xxx', '', '')
"	return _hl
"endfunction
" }}}

" 折り畳み {{{
set foldmethod=marker
" }}}

