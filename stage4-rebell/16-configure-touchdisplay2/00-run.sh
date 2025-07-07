#!/bin/bash -e

echo "DC: RS: 0: `date` $PWD $0"

# *assumes* you have touch display 2 and need to rotate the screen...
on_chroot << PQR
    (
      echo '# Source: 16-configure-touchscreen-2'
      echo '# Assumes you have Touch Display 2 and need to rotate the screen'
      echo '# TODO: Detect the screen by name or by size?'
      echo 'Section "Monitor"'
      echo '    Identifier "DSI-1"'
      echo '    Option "Rotate" "left"'
      echo 'EndSection'
    ) > /usr/share/X11/xorg.conf.d/90-monitor.conf 
PQR

echo "DC: RS: 1: `date` $PWD $0"

