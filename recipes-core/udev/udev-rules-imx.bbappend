FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_smarcimx8mp2g = " file://usb-power.rules"
SRC_URI_append_smarcimx8mp4g = " file://usb-power.rules"
SRC_URI_append_smarcimx8mp6g = " file://usb-power.rules"

do_install_append_smarcimx8mp2g () {
        install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}

do_install_append_smarcimx8mp4g () {
        install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}

do_install_append_smarcimx8mp6g () {
        install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/usb-power.rules ${D}${sysconfdir}/udev/rules.d/
}
