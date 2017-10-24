DFROOT	:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
.DEFAULT_GOAL	:= help

_LNKOPT	= --symbolic --force --verbose
LNK	:= \ln $(_LNKOPT)
_MDROPT	= --parent --verbose
MDR	:= \mkdir $(_MDROPT)
_ERAOPT	= --force --recursive --verbose
ERA	:= \rm $(_ERAOPT)

XDG_CONFIG_HOME	= $(HOME)/.config
XDG_CACHE_HOME	= $(HOME)/.cache
XDG_DATA_HOME	= $(HOME)/.local/share
XDG_BIN_HOME	= $(HOME)/.local/bin
DF_XDG_CONFIG_HOME	= $(DFROOT)/config
#DF_XDG_CACHE_HOME	= $(DFROOT)/cache
#DF_XDG_DATA_HOME	= $(DFROOT)/local/share
#DF_XDG_BIN_HOME	= $(DFROOT)/local/bin

.PHONY:	all # {{{1
all: profile 
# }}}1

.PHONY:	dply # {{{1
dply:
# }}}1

.PHONY:	profile # {{{1
profile:
	$(LNK) "$(DFROOT)/profile" "$(HOME)/.profile"
	$(SHELL) "$(HOME)/.profile"
# }}}1

.PHONY:	getxtheme # {{{1
getxtheme:
	@\echo 'OSX iTheme'
	@\wget 'https://github.com/LinxGem33/OSX-Arc-Shadow/archive/v1.4.3.tar.gz' --verbose -O - |\
		\tar zxfv -
# }}}1

.PHONY:	getxicon # {{{1
getxicon:
	@\echo 'macOS iCons'
	@\wget 'https://dl.opendesktop.org/api/files/download/id/1507938583/macOS.tar.xz' --verbose -O - |\
		\tar Jxfv -
	@\echo 'Numix icon theme'
	@\wget 'https://github.com/numixproject/numix-icon-theme/archive/master.zip' --verbose -O ./numix-icon.zip &&\
		\unzip ./numix-icon.zip
	@\echo 'Papirus icon theme for Linux'
	@\wget -qO- 'https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-root.sh' |\
		\sh
# }}}1

.PHONY:	getxcursor # {{{1
getxcursor:
	@\echo 'Numix cursor theme for Linux'
	@\wget 'https://github.com/numixproject/numix-cursor-theme/archive/master.zip' --verbose -O ./numix-cursor.zip &&\
		\unzip ./numix-cursor.zip
# }}}1

.PHONY:	getfont # {{{1
getfont:
	@\echo 'M+ FONTS'
	@\wget 'https://ja.osdn.net/frs/redir.php?m=iij&f=%2Fmplus-fonts%2F62344%2Fmplus-TESTFLIGHT-062.tar.xz' --verbose -O - |\
		\tar Jxfv -
	@\echo 'Google Noto Font'
	@\wget 'https://noto-website.storage.googleapis.com/pkgs/Noto-hinted.zip' --verbose -O ./noto.zip &&\
		\unzip ./noto.zip
	@\echo 'IPA フォント'
	@\wget 'http://ipafont.ipa.go.jp/old/ipafont/IPAfont00303.php' --verbose -O ./ipa.zip &&\
		\unzip ./ipa.zip
	@\wget 'http://dl.ipafont.ipa.go.jp/IPAexfont/IPAexfont00301.zip' --verbose -O ./ipaex.zip &&\
		\unzip ./ipaex.zip
# }}}1

.PHONY:	xdg # {{{1
xdg:
	$(MDR) $(HOME)/.config
	$(MDR) $(HOME)/.cache
	$(MDR) $(HOME)/.local/share
	$(MDR) $(HOME)/.local/bin
	$(MDR) $(HOME)/.desktop.d
	$(MDR) $(HOME)/dl
	$(MDR) $(HOME)/.template.d
	$(MDR) $(HOME)/.publicshare.d
	$(MDR) $(HOME)/doc
	$(MDR) $(HOME)/music
	$(MDR) $(HOME)/img
	$(MDR) $(HOME)/video
	$(LNK) $(DF_XDG_CONFIG_HOME)/user-dirs.dirs $(XDG_CONFIG_HOME)/user-dirs.dirs
	$(LNK) $(DF_XDG_CONFIG_HOME)/user-dirs.locale $(XDG_CONFIG_HOME)/user-dirs.locale
	\xdg-user-dirs-update && \xdg-user-dirs-gtk-update
	$(MDR) $(XDG_CONFIG_HOME)/autostart
	$(LNK) $(DF_XDG_CONFIG_HOME)/autostart/Xprofile.desktop $(XDG_CONFIG_HOME)/autostart/Xprofile.desktop
	#$(MDR) $(HOME)/tmp
	#$(MDR) $(HOME)/p8g
# }}}1

.PHONY:	x11 # {{{1
x11:
	$(MDR) $(XDG_CONFIG_HOME)/X11
	# Xinitrc
	$(LNK) $(DF_XDG_CONFIG_HOME)/X11/Xinitrc $(XDG_CONFIG_HOME)/X11/Xinitrc
	# Xprofile
	$(LNK) $(DF_XDG_CONFIG_HOME)/X11/xprofile.d/default.xprofile $(XDG_CONFIG_HOME)/X11/Xprofile
	\chmod gu+rwx $(XDG_CONFIG_HOME)/X11/Xprofile
	# Xresources
	$(LNK) $(DF_XDG_CONFIG_HOME)/X11/Xresources $(XDG_CONFIG_HOME)/X11/Xresources
	$(MDR) $(XDG_CONFIG_HOME)/X11/xresources.d
	$(LNK) $(wildcard $(DF_XDG_CONFIG_HOME)/X11/xresources.d/*.xresources) $(XDG_CONFIG_HOME)/X11/xresources.d/
	\xrdb $(XDG_CONFIG_HOME)/X11/Xresources
	# Xmodmap
	#$(MDR) $(XDG_CONFIG_HOME)/X11/xmodmap.d
	$(LNK) $(DF_XDG_CONFIG_HOME)/X11/xmodmap.d/$(PCTYPE).xmodmap $(XDG_CONFIG_HOME)/X11/Xmodmap
	\xmodmap $(XDG_CONFIG_HOME)/X11/Xmodmap
# }}}1

.PHONY:	gpg # {{{1
gpg:
	$(MDR) $(XDG_CONFIG_HOME)/gnupg
# }}}1

.PHONY:	pulse # {{{1
pulse:
	$(MDR) $(XDG_CONFIG_HOME)/pulse
	$(LNK) $(DF_XDG_CONFIG_HOME)/pulse/client.conf $(XDG_CONFIG_HOME)/pulse/client.conf
	$(MDR) $(XDG_CACHE_HOME)/pulse
# }}}1

.PHONY:	plank # {{{1
plank:
	# 設定
	$(MDR) $(XDG_CONFIG_HOME)/plank/dock1/launchers/
# }}}1

.PHONY:	git # {{{1
git:
	$(MDR) $(XDG_CONFIG_HOME)/git
# }}}1

.PHONY:	readline # {{{1
readline:
	# 設定
	$(MDR) $(XDG_CONFIG_HOME)/readline
	$(LNK) $(DF_XDG_CONFIG_HOME)/readline/inputrc $(XDG_CONFIG_HOME)/readline/inputrc
# }}}1

.PHONY:	bash # {{{1
bash:
	# 初期化
	$(ERA) $(wildcard $(HOME)/.bashrc*)
	$(ERA) $(wildcard $(HOME)/.bash_profile*)
	# 設定
	$(MDR) $(XDG_CONFIG_HOME)/bash
	$(LNK) $(DF_XDG_CONFIG_HOME)/bash/init.bash $(XDG_CONFIG_HOME)/bash/init.bash
	# 一時
	$(MDR) $(XDG_DATA_HOME)/bash
	# 資源
	$(MDR) $(XDG_DATA_HOME)/bash
	\bash $(HOME)/.profile
# }}}1

.PHONY:	zsh #{{{1
zsh:
	# 設定
	$(MDR) $(XDG_CONFIG_HOME)/zsh
	$(LNK) $(DF_XDG_CONFIG_HOME)/zsh/init.zsh $(XDG_CONFIG_HOME)/zsh/init.zsh
	# 一時
	$(MDR) $(XDG_DATA_HOME)/zsh
	# 資源
	$(MDR) $(XDG_DATA_HOME)/zsh
	\zsh $(HOME)/.profile
# }}}1

.PHONY:	gem #{{{1
gem:
	$(MDR) $(XDG_DATA_HOME)/gem
# }}}1

.PHONY:	vim #{{{1
vim:
	# 初期化
	$(ERA) $(wildcard $(HOME)/.vimrc*)
	# 設定
	$(MDR) $(XDG_CONFIG_HOME)/vim
	$(LNK) $(DF_XDG_CONFIG_HOME)/vim/init.vim $(XDG_CONFIG_HOME)/vim/init.vim
	$(MDR) $(XDG_CONFIG_HOME)/vim/rc
	$(LNK) $(wildcard $(DF_XDG_CONFIG_HOME)/vim/rc/*.vim) $(XDG_CONFIG_HOME)/vim/rc/
	# 一時
	$(MDR) $(XDG_CACHE_HOME)/vim
	$(MDR) $(XDG_CACHE_HOME)/vim/undo
	$(MDR) $(XDG_CACHE_HOME)/vim/swap
	$(MDR) $(XDG_CACHE_HOME)/vim/bkp
	# 資源
	$(MDR) $(XDG_DATA_HOME)/vim
	# 拡張
	$(MDR) $(XDG_CONFIG_HOME)/vim/autoload
	#@\if \[ -f "$(XDG_CONFIG_HOME)/vim/autoload/plug.vim" ]; then\
		#\wget 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' --verbose -O "$(XDG_CONFIG_HOME)/vim/autoload/plug.vim";\
	#fi
# }}}1

.PHONY: misc # {{{1
misc:
	# wget
	$(MDR) $(XDG_CACHE_HOME)/wget
# }}}1

.PHONY:	blesh # {{{1
blesh:
	# だめ。これ何一つ成功しない。
	# 取得もしくは更新
	#@\if \[ -d "$(XDG_DATA_HOME)/blesh/.git" ]; then\
	#	\git --git-dir="$(XDG_DATA_HOME)/blesh/.git" --work-tree="$(XDG_DATA_HOME)/blesh" pull;\
	#else\
	#	\echo 'ble.sh を GitHub から取得します。';\
	#	\git clone --branch support-vi-mode 'https://github.com/akinomyoga/ble.sh.git' "$(XDG_DATA_HOME)/blesh";\
	#fi
	#\make --makefile="$(XDG_DATA_HOME)/blesh/Makefile"
# }}}1

.PHONY:	skk # {{{1
skk:
	# iBus SKK
	@\echo 'iBus SKK'
	$(MDR) $(XDG_CONFIG_HOME)/libskk/rules/ctm
	$(LNK) $(DF_XDG_CONFIG_HOME)/libskk/rules/ctm/metadata.json $(XDG_CONFIG_HOME)/libskk/rules/ctm/metadata.json
	$(MDR) $(XDG_CONFIG_HOME)/libskk/rules/ctm/rom-kana
	$(LNK) $(DF_XDG_CONFIG_HOME)/libskk/rules/ctm/rom-kana/default.json $(XDG_CONFIG_HOME)/libskk/rules/ctm/rom-kana/default.json
	$(MDR) $(XDG_CONFIG_HOME)/libskk/rules/ctm/keymap
	$(LNK) $(wildcard $(DF_XDG_CONFIG_HOME)/libskk/rules/ctm/keymap/*.json) $(XDG_CONFIG_HOME)/libskk/rules/ctm/keymap/
	\ibus restart
# }}}1

.PHONY:	test # {{{1
test:
	@\echo 'test ユーティリティは現在準備中です。'
# }}}1

.PHONY:	help # {{{1
help:
	@\echo 'help ユーティリティは現在準備中です。'
# }}}1

# TODO:
# test, help 作成
# vim でプラグイン自動読み込み (vim --cmd "hoge" とか)

