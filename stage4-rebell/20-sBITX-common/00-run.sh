#!/bin/bash -e

echo "DC: RS: 0: `date` $PWD $0"

# /boot/firmware/config.txt changes for sbitx:
# 1) disable snd-bccm2835 headphones audio
# 2) disable vc4-kms-v3d (standard 3d video stack) hdmi audio
# 3) disable over-voltage warnings
# 4) add wm8731 audio codec support
# 5) add gpio i2c defines
on_chroot << JKL
  sed -i 's/^dtparam=audio=on$/#dtparam=audio=on/' /boot/firmware/config.txt
  sed -i 's/^dtoverlay=vc4-kms-v3d$/dtoverlay=vc4-kms-v3d,noaudio/' /boot/firmware/config.txt
  if [ `grep -c '^# added for sBITX:$' /boot/firmware/config.txt` -eq 0 ]
  then
    (
      echo '# added for sBITX:'
      echo '# disable under-voltage warning'
      echo 'avoid_warnings=1'
      echo '# enable touch 2 display Driver'
      echo 'dtoverlay=vc4-kms-dsi-ili9881-7inch,rotation=270'
      echo '# configure gpu settings'
      echo 'gpu_mem=112'
      echo '# add wm8731 audio codec support'
      echo 'dtoverlay=audioinjector-wm8731-audio'
      echo '# configure gpios'
      echo 'gpio=4,17,27,22,10,9,11,5,26=ip,pu'
      echo 'gpio=7,8,16,23,24,25=op,pu'
      echo '# add gpio i2c defines'
      echo 'dtoverlay=i2c-rtc-gpio,ds1307,i2c_gpio_delay_us=10,bus=2,i2c_gpio_sda=13,i2c_gpio_scl=6'
    ) >> /boot/firmware/config.txt
  fi
JKL

echo "DC: RS: 1: `date` $PWD $0"

# set up the snd_aloop module as required by sbitx
on_chroot << MNO
  echo "options snd_aloop enable=1,1,1,1 index=1,2,3,4" > \
	/etc/modprobe.d/sbitx-loop.conf
  chmod 644 /etc/modprobe.d/sbitx-loop.conf
  if [ `grep -c '^snd_aloop$' /etc/modules` -eq 0 ]
  then
    echo "snd_aloop" >> /etc/modules
  fi
MNO

