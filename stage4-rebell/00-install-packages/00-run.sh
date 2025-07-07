#!/bin/bash -e

# make the directory path we will use to hold non-sbitx ReBell code
# and set the ownership of each directory to the first user.
on_chroot << EOF
if [ ! -d "/home/${FIRST_USER_NAME}/code" ]; then
    mkdir "/home/${FIRST_USER_NAME}/code"
    chown ${FIRST_USER_NAME} "/home/${FIRST_USER_NAME}/code"
fi

if [ ! -d "/home/${FIRST_USER_NAME}/code/rebell" ]; then
    mkdir "/home/${FIRST_USER_NAME}/code/rebell"
    chown ${FIRST_USER_NAME} "/home/${FIRST_USER_NAME}/code/rebell"
fi
EOF
