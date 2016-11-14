#!/bin/sh

if [ `cat /sys/class/leds/tp\-link\:green\:wps/brightness` = "0" ]
then
	logger "Disabled internet, no action"
	exit 0
fi

if [ `cat /sys/class/leds/tp\-link\:green\:3g/brightness` = "255" ]
then
	logger "Disabling youtube"
	echo 0 > /sys/class/leds/tp\-link\:green\:3g/brightness
	iptables -I FORWARD -m set --match-set youtube dst,src -s 192.168.1.10 -j REJECT
else
	logger "Enabling youtube"
	echo 255 > /sys/class/leds/tp\-link\:green\:3g/brightness
	iptables -D FORWARD -m set --match-set youtube dst,src -s 192.168.1.10 -j REJECT
fi

