# Cinfigure Busybox
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://defconfig \
	file://ftpget.cfg \
	"
