#!/bin/bash -e

on_chroot << EOF
cd  "/home/${FIRST_USER_NAME}/code/rebell"
if [ ! -d "WiringPi" ]; then
    # Use official repo since it claims it supports Pi4 and Pi5 except GCLK
    #git clone --depth 1 https://github.com/Rhizomatica/WiringPi
    git clone --depth 1 https://github.com/WiringPi/WiringPi
fi
cd WiringPi
./build |& tee build.log
ldconfig
chown -R "${FIRST_USER_NAME}" .
EOF
