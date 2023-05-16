FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:smarcimx8mm2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mm2g = " \ 
	${systemd_unitdir}/system/* \
	${systemd_unitdir}/system/* \
"

do_install:append:smarcimx8mm2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system
	
	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

SRC_URI:append:smarcimx8mm4g = " \
        file://disable-serialgetty.sh \
        file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mm4g = " \
	${systemd_unitdir}/system/* \
	${systemd_unitdir}/system/* \
"

do_install:append:smarcimx8mm4g() {
        install -d ${D}${systemd_unitdir}/system
        install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
        install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
        install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

        ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
                ${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

SRC_URI:append:pitximx8mp2g = " \
        file://disable-serialgetty.sh \
        file://disable-serialgetty.service \
"
FILES:${PN}:append:pitximx8mp2g = " \
	${systemd_unitdir}/system/* \
	${systemd_unitdir}/system/* \
"

do_install:append:pitximx8mp2g() {
        install -d ${D}${systemd_unitdir}/system
        install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
        install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
        install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

        ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
                ${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

SRC_URI:append:pitximx8mp4g = " \
        file://disable-serialgetty.sh \
        file://disable-serialgetty.service \
"
FILES:${PN}:append:pitximx8mp4g = " \
	${systemd_unitdir}/system/* \
	${systemd_unitdir}/system/* \
"

do_install:append:pitximx8mp4g() {
        install -d ${D}${systemd_unitdir}/system
        install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
        install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
        install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

        ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
                ${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

SRC_URI:append:pitximx8mp6g = " \
        file://disable-serialgetty.sh \
        file://disable-serialgetty.service \
"
FILES:${PN}:append:pitximx8mp6g = " \
	${systemd_unitdir}/system/* \
	${systemd_unitdir}/system/* \
"

do_install:append:pitximx8mp6g() {
        install -d ${D}${systemd_unitdir}/system
        install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
        install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
        install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

        ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
                ${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}
