#!/bin/bash -e

echo "DC: RS: 0: `date` $PWD $0"

# turn off wayland since it breaks screenshots, keyboard stays in uk mode etc
on_chroot << PQR
  SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_wayland W1
PQR

echo "DC: RS: 1: `date` $PWD $0"

