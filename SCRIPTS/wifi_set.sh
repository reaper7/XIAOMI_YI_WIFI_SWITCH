#!/bin/sh
###########################################
#
# XIAOMI YI WIFI AP/STA SHUTTER SWITCH
# (2016-01-08)
# reaper7
# https://github.com/reaper7/XIAOMI_YI_WIFI_SWITCH
#
# sta fix by Halvaborsch <dsequence@gmail.com>
# https://github.com/halvaborsch/
#
###########################################

GPIO=`cat /proc/ambarella/gpio`

shutter_led_blink()
{
    for i in $( seq 1 ${1} );
    do
        /usr/local/share/script/t_gpio.sh 12 0
        sleep 0.25
        /usr/local/share/script/t_gpio.sh 12 1
        sleep 0.25
    done
}

if [ $# -ne 0 ]; then
  # if wifi_set.sh is started with any parameters then default mode is set to STA
  MODESET=0;
else
  # variable MODESET: 1 AP; 0 STA (based od reading gpio 13 => shutter)
  # when shutter is pressed then return 0 and when released then return 1 
  MODESET=${GPIO:13:1}
fi

if [ -f /tmp/fuse_d/MISC/wifi.conf ]; then rm -f /tmp/fuse_d/MISC/wifi.conf; fi

if [ ${MODESET} -eq 0 ]; then
  cp -f /tmp/fuse_d/MISC/TMP.WIFI.CONF /tmp/fuse_d/MISC/wifi.conf
  sed -i 's/WIFI_MODE=ap/WIFI_MODE=sta/g' /tmp/fuse_d/MISC/wifi.conf

  # by Halvaborsch <dsequence@gmail.com>
  # https://github.com/halvaborsch/
  # The problem is: 
  # lnx system has two diffrent version of wpa_supplicant file
  mkdir -p /tmp/bcmdhd/;
  cp /usr/local/bcmdhd/* /tmp/bcmdhd/;
  rm /tmp/bcmdhd/wpa_supplicant;
  ln -s /usr/bin/wpa_supplicant /usr/local/bcmdhd/wpa_supplicant;
  mount --bind /tmp/bcmdhd/ /usr/local/bcmdhd/;
  
  shutter_led_blink 2
else
  cp -f /tmp/fuse_d/MISC/TMP.WIFI.CONF /tmp/fuse_d/MISC/wifi.conf
  sed -i 's/WIFI_MODE=sta/WIFI_MODE=ap/g' /tmp/fuse_d/MISC/wifi.conf
  
  shutter_led_blink 1
fi

sleep 0.5
