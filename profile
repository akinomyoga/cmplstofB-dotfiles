# 生成ファイルの許可値
umask 0002

# core ファイル
ulimit -c unlimited

# 初期化
unalias -a

# 環境の設定 {{{1

# path
PATH='/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin'
export PATH

# langage
LANG='ja_JP.UTF-8'
export LANG

# editors
PAGER='less'
export PAGER
VISUAL='vim'
export VISUAL
EDITOR='vim'
export EDITOR

# man
MANOPT='--default --all'
export MANOPT

# less
LESS='--quit-at-eof --force --quit-if-one-screen --hilite-search --ignore-case --quit-on-intr --LONG-PROMPT --line-numbers --QUIET --RAW-CONTROL-CHARS --tilde'
export LESS
LESSCHARSET='utf-8'
export LESSCHARSET

# ls
LS_OPTIONS='--color=always --group-directories-first --indicator-style=classify --literal --sort=time'
export LS_OPTIONS

# GCC
GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GCC_COLORS

# FHS 及び XDG Base Directory Specification {{{2

# XDG_CONFIG_HOME:  個人用の /etc {{{3

XDG_CONFIG_HOME="${HOME}/.config"
if [ -d "${XDG_CONFIG_HOME}" ]; then
	export XDG_CONFIG_HOME
	VIMINIT="let \$MYVIMRC = expand(\$XDG_CONFIG_HOME) . '/vim/init.vim' | source \$MYVIMRC"
	export VIMINIT
	XINITRC="${XDG_CONFIG_HOME}/X11/Xinitrc"
	if [ -f "${XINITRC}" ]; then
		export XINITRC
	fi
	X="${XDG_CONFIG_HOME}/X11/Xserverrc"
	if [ -f "${X}" ]; then
		export X
	fi
	READLINE_CONFDIR_HOME="${XDG_CONFIG_HOME}/readline"
	INPUTRC="${READLINE_CONFDIR_HOME}/inputrc"
	if [ -f "${INPUTRC}" ]; then
		export INPUTRC
	fi
	GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
	if [ -d "${GNUPGHOME}" ]; then
		export GNUPGHOME
	fi
	#LESSKEY="${XDG_CONFIG_HOME}/less/cfg.less"
	#if [ -f "${LESSKEY}" ]; then
	#	export LESSKEY
	#	\lesskey $LESSKEY
	#fi
	GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
	test -f "${GTK_RC_FILES}" && export GTK_RC_FILES
	GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
	test -f "${GTK2_RC_FILES}" && export GTK2_RC_FILES
	XCOMPOSEFILE="${XDG_CONFIG_HOME}/X11/xcompose"
	export XCOMPOSEFILE
	MPLAYER_HOME="${XDG_CONFIG_HOME}/mplayer"
	export MPLAYER_HOME
fi

# }}}3

# XDG_CACHE_HOME:  個人用の /var, /tmp {{{3

XDG_CACHE_HOME="${HOME}/.cache"
if [ -d "${XDG_CACHE_HOME}" ]; then
	export XDG_CACHE_HOME
	LESSHISTFILE="${XDG_CACHE_HOME}/lesshst"
	export LESSHISTFILE
fi
# }}}3

# XDG_DATA_HOME:  個人用の /usr/share {{{3

XDG_DATA_HOME="${HOME}/.local/share"
if [ -d "${XDG_DATA_HOME}" ]; then
	export XDG_DATA_HOME
	USERSKKDIR="${XDG_DATA_HOME}/skk"
	if [ -d "${USERSKKDIR}" ]; then
		export USERSKKDIR
	fi
	GEM_HOME="${XDG_DATA_HOME}/gem"
	if [ -d "${GEM_HOME}" ]; then
		export GEM_HOME
	fi
fi

# }}}3

# 非公式 XDG_BIN_HOME:  個人用の /usr/bin {{{3

XDG_BIN_HOME="${HOME}/.local/bin"
if [ -d "${XDG_BIN_HOME}" ]; then
	export XDG_BIN_HOME
	PATH="${XDG_BIN_HOME}:${PATH}"
fi

# }}}3

# XDG_RUNTIME_DIR:  利用者用の一時ディレクトリ {{{3

#XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
#export XAUTHORITY
test ! -d "${XDG_RUNTIME_DIR}/X11" && command -p mkdir "${XDG_RUNTIME_DIR}/X11"
#command -p mkdir --parents "${XDG_RUNTIME_DIR}/X11"
test -d "${XDG_RUNTIME_DIR}/X11" && {
	ICEAUTHORITY="${XDG_RUNTIME_DIR}/X11/ICEauthority"
	export ICEAUTHORITY
	RXVT_SOCKET="${XDG_RUNTIME_DIR}/X11/urxvtd"
	export RXVT_SOCKET
}

# }}}3

# TeXLive (2017) 関係 {{{3

type tex > /dev/null 2>&1 && {
	TEXLIVE_VERSION='2017'
	TEXDIR="/usr/local/share/tug/tl/${TEXLIVE_VERSION}"
	test -f "${TEXDIR}" && export TEXDIR
	TEXMFLOCAL="/usr/local/share/tug/tl/local"
	test -f "${TEXMFLOCAL}" && export TEXMFLOCAL
	TEXMFSYSCONFIG="/etc/tug/tl/${TEXLIVE_VERSION}"
	test -f "${TEXMFSYSCONFIG}" && export TEXMFSYSCONFIG
	TEXMFSYSVAR="/var/tmp/tug/tl/${TEXLIVE_VERSION}"
	test -f "${TEXMFSYSVAR}" && export TEXMFSYSVAR
	TEXMFHOME="${XDG_DATA_HOME}/share/tug/tl"
	test -f "${TEXMFHOME}" && export TEXMFHOME
	TEXMFCONFIG="${XDG_CONFIG_HOME}/tug/tl/${TEXLIVE_VERSION}"
	test -f "${TEXMFCONFIG}" && export TEXMFCONFIG
	TEXMFVAR="${XDG_CACHE_HOME}/tug/tl/${TEXLIVE_VERSION}"
	test -f "${TEXMFVAR}" && export TEXMFVAR
}

# }}}3

# }}}2

# }}}1

# 起動しているシェルを判定し，設定を読み込む {{{1

case `command -p ps --no-headers --format='args' $$` in
	*bash*)
		BASHRC="${XDG_CONFIG_HOME}/bash/init.bash"
		if [ -f "${BASHRC}" ]; then
			source "${BASHRC}"
		else
			:
		fi
		;;
	*zsh*)
		ZSHRC="${XDG_CONFIG_HOME}/zsh/init.zsh"
		if [ -f "${ZSHRC}" ]; then
			source "${ZSHRC}"
		else
			:
		fi
		;;
	*)
		;;
esac

# }}}1

# vim: ft=sh
