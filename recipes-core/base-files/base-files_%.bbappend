FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_smarcimx8mp2g = " \
        file://embedian-hdmi-audio.conf \
"

SRC_URI_append_smarcimx8mp4g = " \
	file://embedian-hdmi-audio.conf \
"

SRC_URI_append_smarcimx8mp6g = " \
        file://embedian-hdmi-audio.conf \
"

do_install_append_smarcimx8mp2g() {
        install -m 0644 ${WORKDIR}/embedian-hdmi-audio.conf ${D}${sysconfdir}/modprobe.d
}

do_install_append_smarcimx8mp4g() {
	install -m 0644 ${WORKDIR}/embedian-hdmi-audio.conf ${D}${sysconfdir}/modprobe.d
}

do_install_append_smarcimx8mp6g() {
        install -m 0644 ${WORKDIR}/embedian-hdmi-audio.conf ${D}${sysconfdir}/modprobe.d
}
