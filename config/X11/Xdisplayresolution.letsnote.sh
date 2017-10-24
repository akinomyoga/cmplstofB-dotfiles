#!/bin/sh - 
# 
# xdisplayresolution.sh --- 解像度の設定（8:5 にする） 
# 

displayname='eDP-1' # 出力先 
displaymode='1440x900_60.00' # 画面解像度 
displaymodeconfig='106.50  1440 1528 1672 1904  900 903 909 934' # 同期関連 

\xrandr --newmode \"${displaymode}\" ${displaymodeconfig} -hsync +vsync && 
\xrandr --addmode ${displayname} \"${displaymode}\" && 
\xrandr --output ${displayname} --mode \"${displaymode}\" 
