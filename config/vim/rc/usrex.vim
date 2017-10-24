scriptencoding utf-8

set packpath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after

" min-pac {{{1

silent! packadd minpac

if !exists('*minpac#init')

else

	call minpac#init()

	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('vim-jp/vimdoc-ja')
	call minpac#add('altercation/vim-colors-solarized')
	"call minpac#add('machakann/vim-sandwich')

endif

command! PackUpdate packadd minpac|source<space>$MYVIMRC|call<space>minpac#update()
command! PackClean packadd minpac|source<space>$MYVIMRC|call<space>minpac#clean()

" }}}1

" vim-plug {{{1

"" TODO: IsPlugged() みたいな函数作る
"
"" 変数
"let $VIM_PLUG_HOME = expand($MYVIMDATADIR) . "/plugged"
"
"" 列挙
"call plug#begin(expand($VIM_PLUG_HOME))
"Plug 'vim-jp/vimdoc-ja'
"Plug 'altercation/vim-colors-solarized'
"Plug 'machakann/vim-sandwich'
"" 保留。Vim 8 向けに自作するか……。
""Plug 'tyru/eskk.vim'
"Plug 'itchyny/calendar.vim'
"call plug#end()

" }}}1

" altercation/vim-colors-solarized {{{1

if 1
	set background=dark
	let g:solarized_termtrans = 1
	let g:solarized_bold = 1
	let g:solarized_italic = 1
	let g:solarized_visibility = "normal"
	colorscheme solarized
endif

" }}}1

" machakann/vim-sandwich {{{1

"if 1
"
"	" vim-surround 風に
"	runtime macros/sandwich/keymap/surround.vim
"
"	" 追加
"	let g:sandwich#recipes += 
"				\ [ {
"				\ 'buns': ['(', ')'],
"				\ 'nesting': 1,
"				\ 'match_syntax': 1,
"				\ 'kind': ['add', 'replace'],
"				\ 'action': ['add'],
"				\ 'input': ['p']
"				\ }, {
"				\ 'buns': ['{', '}'],
"				\ 'nesting': 1,
"				\ 'match_syntax': 1,
"				\ 'kind': ['add', 'replace'],
"				\ 'action': ['add'],
"				\ 'input': ['b']
"				\ }, {
"				\ 'buns': ['[', ']'],
"				\ 'nesting': 1,
"				\ 'match_syntax': 1,
"				\ 'kind': ['add', 'repqace'],
"				\ 'action': ['add'],
"				\ 'input': ['s']
"				\ }, {
"				\ 'buns': ["'", "'"],
"				\ 'nesting': 1,
"				\ 'match_syntax': 1,
"				\ 'kind': ['add', 'repqace'],
"				\ 'action': ['add'],
"				\ 'input': ['q']
"				\ }, {
"				\ 'buns': ['"', '"'],
"				\ 'nesting': 1,
"				\ 'match_syntax': 1,
"				\ 'kind': ['add', 'replace'],
"				\ 'action': ['add'],
"				\ 'input': ['Q']
"				\ } ]
"
"endif

" }}}1

" tyru/eskk.vim {{{1

"let g:eskk#large_dictionary = {
"			\ 'path': expand($USERSKKDIR) . "/dic/SKK-JISYO.C",
"			\ 'sorted': 1,
"			\ 'encoding': 'euc-jp',
"			\ }
"let g:eskk#dictionary = {
"			\ 'path': expand($USERSKKDIR) . "/dic/usr/eskk_vim.skkdic",
"			\ 'sorted': 0,
"			\ 'encoding': 'utf-8',
"			\ }
"let g:eskk#marker_henkan = "▾"
"let g:eskk#marker_henkan_select = "▿"
"augroup EskkRtKHMap
"	autocmd!
"	autocmd VimEnter,User eskk-initialize-pre call s:eskk_initial_pre()
"	function! s:eskk_initial_pre()
"		let r2h = eskk#table#new('rom_to_hira*', 'rom_to_hira')
"		call r2h.add_map('+', 'ー')
"		call r2h.add_map('<', '！')
"		call eskk#register_mode_table('hira', r2h)
"		let r2k = eskk#table#new('rom_to_kata*', 'rom_to_kata')
"		call r2k.add_map('+', 'ー')
"		call r2k.add_map('<', '！')
"		call eskk#register_mode_table('kata', r2k)
"	endfunction
"augroup END

" }}}1

" itchyny/calendar.vim {{{1

"let g:calendar_cache_directory = expand($XDG_CACHE_HOME) . "/vim/calendar"
"augroup MapInVimCalender
"	autocmd FileType calendar nunmap <buffer> <C-n>
"	autocmd FileType calendar nunmap <buffer> <C-p>
"augroup END

" }}}1

