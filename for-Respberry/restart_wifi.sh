#!/bin/sh
#restart wifi

sudo ifdown  wlan0
sleep 1
sudo ifup  wlan0
sleep 5
ifconfig
