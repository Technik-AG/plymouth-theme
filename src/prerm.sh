#!/bin/sh

set -e

if [ "x$1" = xremove ]; then
	update-alternatives \
		--remove default.plymouth /usr/share/plymouth/themes/technik-ag/technik-ag.plymouth

	if which plymouth-set-default-theme >/dev/null 2>&1
	then
		plymouth-set-default-theme --reset
	fi
fi

#DEBHELPER#
