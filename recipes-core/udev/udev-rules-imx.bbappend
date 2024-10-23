FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://usb-power.rules"

do_install:append () {
	install -d ${D}${sysconfdir}/udev/rules.d
	install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}
