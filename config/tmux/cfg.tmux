# 端末制御
set -g default-terminal "tmux-256color"
# 環境読み込み
set -g default-command "${SHELL}"
#set -ga terminal-overrides ',*:Ss=\eE[%p1%d q:Se=\eE[2 q'
#set -ga terminal-overrides ',xterm-256color:Tc'
# Keyboard Delay
set -sg escape-time 0
# 前置電鍵 (C-l)
unbind-key 'C-b'
set -g prefix 'C-l'
bind-key 'C-l' send-prefix
# vi 風の操作
set-window-option -g mode-keys vi
# 電鍵割り当て
bind-key 'space' copy-mode
# window の移動場合によっては制御電鍵を押下したままの方が指動が楽
bind-key n next-window
bind-key p previous-window
bind-key C-n next-window
bind-key C-p previous-window
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
# ポインティングデバイス
set-option -g mouse on
# vim: ft=tmux

