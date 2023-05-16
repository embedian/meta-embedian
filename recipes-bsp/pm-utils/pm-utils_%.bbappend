FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://remove_default_sleep_d.diff \
	file://01-eth.sh \	
"

FILES_${PN} += "${sysconfdir}/pm/sleep.d/*"

do_install:append () {
	install -d ${D}/${sysconfdir}/pm/sleep.d
	install -m 0755 ${WORKDIR}/01-eth.sh ${D}/${sysconfdir}/pm/sleep.d
}
