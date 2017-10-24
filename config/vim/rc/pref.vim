scriptencoding utf-8

" ファイル全体の挙動 {{{1
" 文字符号処理
setglobal fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,sjis,cp932,cp20932
" 改行形式
setglobal fileformat=unix
" 読み込み
filetype on
filetype plugin on
filetype indent on
" 自家組立の場合，そこを参照する。
" なお，'/usr/local/share/vim' は組立設定時の EPREFIX に依存する。大抵は規定の
" まま使うので固定して問題はない。もしも不都合が生じれば考えるが，はたして
" 「自家組立かどうか」なんていうかなり局所的な問題に対応する方法があるか不明。
if isdirectory('/usr/local/share/vim') && isdirectory('/usr/local/share/vim/vim80')
	let $VIM = '/usr/local/share/vim'
	let $VIMRUNTIME = '/usr/local/share/vim/vim80'
else
	let $VIM = '/usr/share/vim'
	let $VIMRUNTIME = '/usr/share/vim/vim80'
endif
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIMRUNTIME,$VIM/vimfiles,$VIM/vimfiles/after
" }}}1

" 情報の保存 {{{1
" 履歴
set history=2000
" 状態の記録
let $MYVIMINFO = expand($XDG_CACHE_HOME) . "/vim/info"
set viminfo='2000,<2000,s2000,h,n$MYVIMINFO
" undo 永続化
set undofile
set undolevels=2000
set undodir=$XDG_CACHE_HOME/vim/undo
" 一時保存
set swapfile
set directory=$XDG_CACHE_HOME/vim/swap
" バックアップ
set backup
set backupdir=$XDG_CACHE_HOME/vim/bkp
set writebackup
set autoread
set hidden
let $MYVIMSESSIONFILE = expand($MYVIMDATADIR) . "/session"
augroup SaveSession
	autocmd!
	autocmd VimLeave * mksession! $MYVIMSESSIONFILE
augroup END
function! s:RestoreCursorPostion()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction
augroup SaveCursorPos
	autocmd!
	autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END

" }}}1

" 基本的な動作 {{{1

" 処理時間
set timeoutlen=400
set ttimeoutlen=-1
" 下部の表示形態
setglobal display=lastline
setglobal showcmd
set showmode
set showmatch
" ポインティングデバイス
set mouse=
set mousefocus
set nomousehide
" 削除可能条件
setglobal backspace=indent,eol,start
" 桁送り
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set copyindent
" 警告
set noerrorbells
set novisualbell
set belloff=all
" 表題
set title
" 増減可能形態
set nrformats=hex
" 検索
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
" 手引き
set helplang=ja
set helpheight=12
" Shell
set sh=bash\ --login
let $BASHRC = expand($XDG_CONFIG_HOME) . '/bash/init.sh'
if filereadable(expand($BASHRC))
	let $BASH_ENV = expand($BASHRC)
endif
" ディレクトリ関連
setglobal noautochdir
augroup AutoChangeDir
	autocmd!
	autocmd BufEnter * execute ':lcd ' . expand("%:p:h")
augroup END

" 日本語入力
set noimdisable
let IM_CtrlMode = 1
" i-Bus 連携
"function! IMCtrl(cmd)
"	let cmd = a:cmd
"	if cmd == 'On'
"		let res = system('ibus'.'engine'.'"skk"')
"	elseif cmd == 'Off'
"		let res = system('ibus'.'engine'.'"xkb:jp::jpn"')
"	endif
"	return ''
"endfunction

" 安全
set noexrc
set nosecure
set cryptmethod=blowfish2

" }}}1

" 形式別の挙動 {{{1
" 命令欄での挙動
set wildmenu
set wildmode=list,full
augroup CompPathAfterEqual
	autocmd!
	autocmd FileType Makefile setlocal isfname-== isfname+=32
augroup END
" }}}1

