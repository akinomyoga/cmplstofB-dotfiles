: '初期設定' && { #{{{1
# 対話態でなければ何もせず終了
case $- in
	*i*) ;;
	*) return;;
esac

# システム設定の読み込み
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi
} #}}}1

: 'ble.sh 設定 (上部)' && { #{{{1

BLESH_BIN="${XDG_BIN_HOME}/blesh"
#BLESH_BIN="${XDG_DATA_HOME}/blesh/ble.sh"

# 対話態かつ ble.sh 初期実行ファイルが存在していれば続いての行を実行する。
if [[ $- == *i* && -f "${BLESH_BIN}" ]] && source "$BLESH_BIN" noattach; then

	# ble.sh の環境設定
	# 東欧文字幅
	bleopt char_width_mode='west'
	# 文字符号化形式
	bleopt input_encoding='UTF-8'
	# 警告音
	bleopt edit_abell=
	# 通知
	export bleopt_ignoreeof_message='Shell を終了するには `$ exit` を実行して下さい'

	# 入力方式
	# Vim 風
	bind 'set editing-mode vi'

	source "$_ble_base/keymap/vi.sh"
	# 状態の表示
	bleopt keymap_vi_normal_mode_name=$'\e[1m-- NORMAL --\e[m'
	# 状態毎のカーソル
	bleopt term_vi_nmap="${_ble_term_Ss//@1/2}"
	bleopt term_vi_imap="${_ble_term_Ss//@1/5}"
	bleopt term_vi_omap="${_ble_term_Ss//@1/4}"
	bleopt term_vi_xmap="${_ble_term_Ss//@1/2}"
	bleopt term_vi_cmap="${_ble_term_Ss//@1/0}"
	# 鍵盤割り当て (C-j は SKK 起動/平仮名態遷移に割り当てているので回避)
	# 挿入
	ble-bind -m 'vi_imap' -f 'C-x C-m' 'accept-line'
	# ノーマル
	ble-bind -m 'vi_nmap' -f 'C-@' 'accept-and-next'
	ble-bind -m 'vi_nmap' -f 'C-c' 'vi-insert/normal-mode'
	ble-bind -m 'vi_nmap' -f 'C-j' 'nop'
	# コマンド (?)
	ble-bind -m 'vi_cmap' -f 'C-m' 'vi_cmap/accept'
	ble-bind -m 'vi_cmap' -f 'C-j' 'nop'

	# 拡張機能読み込み
	source "$_ble_base/lib/vim-surround.sh"
	# 拡張機能の設定
	bleopt vim_surround_45:=$'$( \r )' # for ysiw-
	bleopt vim_surround_61:=$'$(( \r ))' # for ysiw=
	bleopt vim_surround_q:=\' # for ysiwq
	bleopt vim_surround_Q:=\" # for ysiwQ

	# コマンドライン機能の追加
	# @akinomyoga 様。ここを見られたとしても無視して下さい。
	# TODO:  `:{int}` でその履歴番号を現在行に呼び出し。`ble-edit/history/goto` とか使えば実装できる？
	# TODO:  `:so ${argf}` で行の内容を保持したまま `$ source ${argf}` 実行。
	# TODO:  `:s/old/new/[g]` で行の内容[全体]を置換。`$ ^old^new` とか `$ !:s/old/new/` とかの現状実行。
	#        これに関しては今どんな widget 使えばいいのか思い付かんので放置する。
	# 行転写 (とりあえず)。これ実装できてんのか？ 確かめられん……。
	function ble/widget/vi-command:t {
		ble/widget/vi-nmap/copy-current-line
		return
	}

fi

} #}}}1

: '基本設定' && { #{{{1

# Readline --- こういうのは本当は inputrc あたりで設定できるようにすべきでは？
\tty --silent \
	&& \stty stop undef \
	&& \stty start undef \
	&& \stty rprnt undef \
	&& \stty discard undef \
	&& \stty time 0

# 端末画面の自動取得
shopt -s checkwinsize
# $PATH を常に走査する
shopt -s checkhash

# 履歴
# 重複行及び空白開始行を履歴として保存しない
export HISTCONTROL='ignoreboth'
# ある種のコマンドを履歴として保存しない
export HISTIGNORE="fg:bg:ls:la:ll:v"
# 履歴情報を上書きせず，追加する
shopt -s histappend
# 履歴展開時，実行前に展開結果を確認可能に
shopt -s histverify
# 履歴の置換に失敗した際，再実行可能に
shopt -s histreedit
# 保存場所
export HISTFILE="${XDG_CACHE_HOME}/bash/history"
# 一次記憶 (`history` で呼び出し)
export HISTSIZE='10000'
# ファイル
export HISTFILESIZE='100000'
# 編集
export FCEDIT='vim'

# 特殊展開
# match all files and zero or more directories and subdirectories.
shopt -s globstar
shopt -s nocaseglob

} #}}}1

: '関数・コマンド' && { #{{{1

# 移動先の微修正
shopt -s cdspell
# ディレクトリを第零引数に指定した時は cd の引数と見做す
shopt -s autocd

# 函數 {{{2
# 函數名を階層構造にする概念は @akinomyoga 氏よりパク^H^H参考に。
# option_parser:  option を分析
#function __user_command/option_parser () {
#	declare -i argc=0
#	declare -a argv=()
#	declare -A optV
#	while (( $# > 0 ))
#	# 引数を回してとりあえず - から始まるものを optV 連想配列にぶっこむ。
#};
# list_directory:  目録の中身を表示
function __user_command/list_directory () {
	case "$1" in
		--all)
			local _opt="--almost-all --format=across ${LS_OPTIONS} --width=${COLUMNS}"
			shift
			;;
		--detail)
			local _opt="--almost-all --format=verbose ${LS_OPTIONS} --human-readable --no-group"
			shift
			;;
		--detail)
			local _opt="--almost-all --format=verbose ${LS_OPTIONS} --human-readable --no-group"
			shift
			;;
		--default)
			local _opt="--ignore-backups --format=across ${LS_OPTIONS} --width=${COLUMNS}"
			shift
			;;
	esac
	\command -p ls ${_opt} "$@"
};
function __user_command/change_directory () {
	case "$1" in
		--after-ls)
			shift
			command -p cd $1 &&
			#export __ABBREV_PWD=$(\perl -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<< $(pwd))
			__user_command/list_directory --default
			;;
		*)
			command -p cd $1
			;;
	esac
};
function __user_command/up_directory () {
	local _opt=''
	\command -p cd ./../
};
# Vim 一行処理
function vl () {
	local _opt='-es --cmd'
	local _vlcmd_q='+%p|q!'
	\command -p vim ${_opt} "$@" ${_vlcmd_q}
};
\complete -r vl
# 目録作成後移動
function mcd () {
	exec 3>&1

	cd "`
	if \mkdir "$@" 1>&3; then
		while [ $# -gt 0 ]
		do
			case "$1" in
				-- )
					\printf '%s' "$2";
					exit 0
					;;
				-* )
					shift
					;;
				* )
					\printf '%s' "$1";
					exit 0
					;;
			esac
		done
		\printf '.'
		exit 0
	else
		\printf '.'
		exit 1
	fi
	`"

	exec 3>&-
};
function __user_command/set_locale () {
	case "$1" in
		--posix)
			local _opt='LANG=POSIX'
			shift
			;;
		--ja-JP-UTF-8)
			local _opt='LANG=ja_JP.UTF-8'
			shift
			;;
	esac
	\command -p env ${_opt} "$@"
};

# }}}2

# 別名 {{{2

shopt -s expand_aliases
unalias -a
alias cls='\command -p clear'
complete -r cls
alias l='__user_command/list_directory --light-weight'
alias ls='__user_command/list_directory --default'
alias la='__user_command/list_directory --all'
alias ll='__user_command/list_directory --detail'
alias cd='__user_command/change_directory --after-ls'
alias df='\command -p df --human-readable'
alias du='\command -p du --human-readable'
alias sd='\command -p sudo --preserve-env'
alias mv='\command -p mv --interactive --verbose'
alias wget="\command -p wget --hsts-file=${XDG_CACHE_HOME}/wget/hsts"
alias cp='\command -p cp --recursive --interactive --verbose'
alias mdr='\command -p mkdir --verbose'
alias rm='\command -p trash-put --verbose'
alias era='\command -p rm --interactive=once --verbose --preserve-root'
alias v='\command -p gvim -v'
# 言語切り替え
alias P='__user_command/set_locale --posix'
alias J='__user_command/set_locale --ja-JP-UTF-8'
# クリップボードの利用
alias cbcp='\command -p xsel --clipboard --input --logfile "${XDG_CACHE_HOME}/xsel.log"'
alias cbpt='\command -p xsel --clipboard --output --logfile "${XDG_CACHE_HOME}/xsel.log"'
# 履歴等を残さずに退去
alias quit='\command -p kill -9 $$'

# }}}2

} #}}}1

: 'プロンプト' && { #{{{1

# TODO:  /usr/local/share/tug みたいなディレクトリを /u/l/s/tug みたいにする
#        ~/.config/libskk は ~/.c/libskk
#function __user_command/abbrev_pwd () {
#	local _raw_pwd="$(pwd)"
#	local _abbrev_pwd="_raw_pwd"
#	export ABBREV_PWD="_abbrev_pwd"
#}
#PROMPT_CMD='__user_command/abbrev_pwd'
if [[ -n "${DISPLAY}" ]]; then
	if [[ -n "${TMUX}" ]]; then
		PS1="\w\n\[\033Ptmux;\033\033[5 q\033\\\\\]"
	else
		PS1="\w\n\[\033[5 q\]"
	fi
else
	PS1="\w\n"
fi

# ↓ これ何の為に存在してんの？
# ${debian_chroot:+($debian_chroot)}

} #}}}1

: '補完' && { #{{{1
# 空行で補完鍵盤を押下しても補完を開始しない
shopt -s no_empty_cmd_completion
if ! shopt -oq posix; then
	BASH_COMPDIR_HOME="${XDG_DATA_HOME}/bash/comp"
	if [ -d "${BASH_COMPDIR_HOME}" ] ; then
		source "${BASH_COMPDIR_HOME}/git.bash"
	fi
fi
} #}}}1

: '起動' && { #{{{1

# Path の調整
_path=''
for _p in $(\echo "$PATH" | \tr ':' ' '); do
	case ":${_path}:" in
		*:"${_p}":*)
			;;
		*)
			if [ "$_path" ]; then
				_path="$_path:$_p"
			else
				_path=$_p
			fi
			;;
	esac
done
PATH=$_path
unset _p
unset _path

# ble.sh
if [[ $- == *i* ]]; then
	# カレントディレクトリに
	\command -p cd $(\pwd)
	if [ -f "${BLESH_BIN}" ]; then
		# ble.sh 作動
		((_ble_bash)) && ble-attach
	fi
fi

} #}}}1

