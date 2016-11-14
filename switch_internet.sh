#!/bin/sh

# @see http://eko.one.pl/forum/viewtopic.php?id=11176

if [ `cat /sys/class/leds/tp\-link\:green\:wps/brightness` = "255" ]
then
	logger "Disabling internet"
	iptables -I FORWARD 1 -p tcp -s 192.168.1.10 -j REJECT
	echo 255 > /sys/class/leds/tp\-link\:green\:3g/brightness
	/root/switch_youtube.sh
	echo 0 > /sys/class/leds/tp\-link\:green\:wps/brightness
else
	logger "Enabling internet"
	iptables -D FORWARD 1
	echo 255 > /sys/class/leds/tp\-link\:green\:wps/brightness
	echo 0 > /sys/class/leds/tp\-link\:green\:3g/brightness
	/root/switch_youtube.sh
fi

