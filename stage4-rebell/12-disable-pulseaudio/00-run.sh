#!/bin/bash -e

on_chroot << EOF
	sed -i 's,; autospawn = yes,autospawn = no,' /etc/pulse/client.conf
	sed -i 's,; daemon-binary = /usr/bin/pulseaudio,daemon-binary = /bin/true,' /etc/pulse/client.conf
EOF
