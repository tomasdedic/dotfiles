#!/bin/bash
#if [ -z "`xrandr --query |grep -a28 eDP-1| awk '/^   1600x900/'`" ]
#then
#        #xrandr --nfwmode "1600x900" 118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync 
#        #xrandr --nfwmode "1600x900" 7.75  1600 1648 1800 2000  60 63 73 76 -hsync +vsync 
#        #xrandr --addmode eDP-1 1600x900 
#        xrandr --output eDP-1 --mode 1920x1080
#        #xrandr --output eDP-1 --gamma 0.8:0.8:0.8 
#        #xbacklight -set 80
#fi
xrandr --output eDP-1 --mode 1920x1080 --primary --pos 0x0 --auto
xrandr --output DP-1 --off
xrandr --output HDMI-2 --off
#killall conky
#conky 1>/dev/null
#nitrogen --restore &
