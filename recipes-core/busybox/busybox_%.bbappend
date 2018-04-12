# Disable TelnetD from Busybox
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://defconfig \
	    file://ftpget.cfg \
	   "
