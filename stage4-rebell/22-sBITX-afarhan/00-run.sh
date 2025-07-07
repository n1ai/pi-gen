#!/bin/bash -e

printf "DC: RS: 0: `date` $PWD $0\n"

# build the afarhan sbitx code 
# NOTE: hacked to get oled.h out of the afarhandev branch
on_chroot << DEF
  set +x
  cd  "/home/${FIRST_USER_NAME}"
  rm -rf sbitx-afarhan  
  git clone --branch farhandev https://github.com/afarhan/sbitx sbitx-afarhan
  pushd sbitx-afarhan
  cp oled.h /tmp
  popd
  rm -rf sbitx-afarhan  
  git clone --branch main https://github.com/afarhan/sbitx sbitx-afarhan
  pushd sbitx-afarhan
  cp /tmp/oled.h .
  pushd ft8_lib
  make clean
  make
  make install || true
  popd
  ./build sbitx
  chown -R "${FIRST_USER_NAME}" .
  popd
  set -x
DEF

echo "DC: RS: 1: `date` $PWD $0"

