# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils 

#MY_PV="${PV/_rc/RC}"

DESCRIPTION="Update system and notify daemon"
HOMEPAGE="http://linuxbuh.ru/gentoo/update-system-notify"
SRC_URI="http:///linuxbuh.ru/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	    unpack ${A}
	    
}

src_install() {
	mkdir -p ${D}/etc/update-system-notify
	mkdir -p ${D}/usr/share/doc/${PN}
	mkdir -p ${D}/usr/sbin
	mkdir -p ${D}/etc/cron.hourly
	cp -r ${WORKDIR}/${PN}/shscript/update-system-notify.sh ${D}/usr/sbin
	cp -r ${WORKDIR}/${PN}/shscript/update-system-notify-daemon.sh ${D}/usr/sbin
	cp -r ${WORKDIR}/${PN}/shscript/update-system-notifyer.sh ${D}/usr/sbin
	cp -r ${WORKDIR}/${PN}/cfg/update-system.cfg ${D}/etc/update-system-notify
	cp -r ${WORKDIR}/${PN}/cfg/update-system-notify.cron ${D}/etc/cron.hourly
	cp -r ${WORKDIR}/${PN}/README.txt ${D}/usr/share/doc/${PN}
	cp -r ${WORKDIR}/${PN}/Changelog.txt ${D}/usr/share/doc/${PN}
	cp -r ${WORKDIR}/${PN}/TODO.txt ${D}/usr/share/doc/${PN}
}

pkg_postinst() {
	elog "The program scans the update overlays and displays a message about the updates to the desktop."
	elog "If necessary, updates the world."
	elog "After installation, edit the following files:"
	elog "1) in /etc/update-system-notify/update-system.cfg enter your DE option"
	elog "for GNOME - gnome-panel parameter for KDE - plasms-desktop"
	elog "2) the file update-system-notify.cron move the folder /etc/cron.hourly /etc/cron.weekly folder or any other"
}
