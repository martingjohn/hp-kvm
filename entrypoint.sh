#!/bin/bash

export DISPLAY=:1

shopt -s nocasematch

/usr/bin/Xvfb ${DISPLAY} -screen 0 ${VNC_RESOLUTION}x24 &

if [[ "x$VNC_PASSWORD" != "x" ]]
then
	mkdir ~/.vnc
	x11vnc -storepasswd $VNC_PASSWORD ~/.vnc/passwd
	/usr/bin/x11vnc -xkb -noxrecord -noxfixes -noxdamage -nopw -wait 5 -shared -permitfiletransfer -tightfilexfer -forever -rfbport ${VNC_PORT} -rfbauth ~/.vnc/passwd &
else
	/usr/bin/x11vnc -xkb -noxrecord -noxfixes -noxdamage -nopw -wait 5 -shared -permitfiletransfer -tightfilexfer -forever -rfbport ${VNC_PORT} &
fi

if [[ "${KVM_SCRIPT}" == "kvm" ]]
then
	/opt/kvm.sh
elif [[ "${KVM_SCRIPT}" == "media" ]]
then
	/opt/media.sh
else
	echo "Unknown option ${KVM_SCRIPT}"
	die
fi

