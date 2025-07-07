#!/bin/bash -e

printf "DC: RS: 0: `date` $PWD $0\n"

# build the n1ai sbitx code 
on_chroot << ABC
  set +x
  cd  "/home/${FIRST_USER_NAME}"
  rm -rf sbitx-n1ai  # dangerous?
  git clone --branch dev-main https://github.com/n1ai/sbitx-mainline sbitx-n1ai
  pushd sbitx-n1ai
  mkdir -p build
  pushd build
  cmake ..
  cmake --build . |& tee build.log
  popd
  chown -R "${FIRST_USER_NAME}" .
  popd
  set -x
ABC

echo "DC: RS: 1: `date` $PWD $0"

