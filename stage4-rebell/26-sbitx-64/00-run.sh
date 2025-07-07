#!/bin/bash -e

printf "DC: RS: 0: `date` $PWD $0\n"

# build the 64 bit sbitx code 
on_chroot << ABC
  set +x
  cd  "/home/${FIRST_USER_NAME}"
  rm -rf sbitx-64  # dangerous?
  git clone --branch main https://github.com/drexjj/sbitx sbitx-64
  pushd sbitx-64
  pushd src/ft8_lib
  make clean
  make
  make install || true
  popd
  ./build sbitx
  chown -R "${FIRST_USER_NAME}" .
  popd
  set -x
ABC

echo "DC: RS: 1: `date` $PWD $0"

# make a symlink to the sbitx version to be used by default
on_chroot << GHI
  cd  "/home/${FIRST_USER_NAME}"
  ln -s "/home/${FIRST_USER_NAME}/sbitx-64" "/home/${FIRST_USER_NAME}/sbitx"
  chown -h "${FIRST_USER_NAME}" "/home/${FIRST_USER_NAME}/sbitx" 
GHI

echo "DC: RS: 2: `date` $PWD $0"


