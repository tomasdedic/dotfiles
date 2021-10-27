#!/bin/bash
if [ -z "`xrandr --query |grep -a28 eDP-1| awk '/^   1920x1080/'`" ]
then
       # xrandr --addmode eDP-1 1600x900 
        xrandr --output eDP-1 --mode 1920x1080
        #xrandr --output eDP-1 --gamma 0.8:0.8:0.8 
        nitrogen --restore &
        #xbacklight -set 80
fi

if [ ! -z "`xrandr --query |awk '/^HDMI-2 connected/'`" ]
then
        xrandr --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --auto
        xrandr --output eDP-1 --off
        #killall conky
        #conky  1>/dev/null
        #nitrogen --restore &
				#openbox --restart &
elif [ ! -z "`xrandr --query | awk '/^DP-1 connected/'`" ]
then     
				#openbox --restart &
        xrandr --output DP-1 --pos 0x0 --mode 1680x1050 --auto --primary
        xrandr --output eDP-1 --off
        #killall conky
        #conky  1>/dev/null
        nitrogen --restore &
#				openbox --restart &
fi


#if [ ! -z "`xrandr --query | awk '/^DP1 connected/'`" ]
#then    
        #xrandr --newmode "1680x1050" 146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
        #xrandr --addmode DP1 1680x1050
#        xrandr --output DP1 --primary --pos 0x0 --mode 1680x1050 --auto 
        #xrandr --output eDP-1 --off
        #xrandr --output eDP-1 --mode 1600x900 --primary --rotate normal --auto --output DP1 --mode 1680x1050 --auto --above eDP-1 
#        xrandr --output eDP-1 --gamma 0.8:0.8:0.8
#        xbacklight -set 100
#else
#        xrandr --output eDP-1 --mode 1600x900 --off --output DP1 --auto
#fi
