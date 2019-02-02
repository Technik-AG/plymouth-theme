#!/bin/sh -e
# This script can be called in the following ways:
#
# After the package was installed:
#       <postinst> configure <old-version>
#
#
# If prerm fails during upgrade or fails on failed upgrade:
#       <old-postinst> abort-upgrade <new-version>
#
# If prerm fails during deconfiguration of a package:
#       <postinst> abort-deconfigure in-favour <new-package> <version>
#                  removing <old-package> <version>
#
# If prerm fails during replacement due to conflict:
#       <postinst> abort-remove in-favour <new-package> <version>


case "$1" in
    configure)
	update-alternatives \
		--install 	/usr/share/plymouth/themes/default.plymouth default.plymouth \
					/usr/share/plymouth/themes/technik-ag/technik-ag.plymouth 200 \
		--slave 	/usr/share/plymouth/themes/default.grub default.plymouth.grub \
					/usr/share/plymouth/themes/technik-ag/technik-ag.grub

	if which plymouth-set-default-theme >/dev/null 2>&1
	then
		plymouth-set-default-theme technik-ag
	fi

	if which update-initramfs >/dev/null 2>&1
	then
		echo FRAMEBUFFER=y | tee /etc/initramfs-tools/conf.d/splash
		update-initramfs -u
	fi
	;;

    abort-upgrade|abort-deconfigure|abort-remove)
	;;

    *)
	echo "$0 called with unknown argument \`$1'" 1>&2
	exit 1
	;;
esac

#DEBHELPER#
exit 0