FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:smarcfimx6qp2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx6qp2g = " \ 
        ${systemd_unitdir}/system/* \
        ${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcfimx6qp1g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx6qp1g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"
SRC_URI:append:smarcfimx6q2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx6q2g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcfimx6q1g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx6q1g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcfimx6dl1g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx6dl1g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcfimx6solo = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx6solo = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcfimx7d2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx7d2g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcfimx7d = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcfimx7d = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"
SRC_URI:append:smarcimx8mm2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mm2g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcimx8mm4g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mm4g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcimx8mp2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mp2g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcimx8mp4g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mp4g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:smarcimx8mp6g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:smarcimx8mp6g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:pitximx8mp2g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:pitximx8mp2g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:pitximx8mp4g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:pitximx8mp4g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

SRC_URI:append:pitximx8mp6g = " \
	file://disable-serialgetty.sh \
	file://disable-serialgetty.service \
"
FILES:${PN}:append:pitximx8mp6g = " \
	${systemd_unitdir}/system/* \
	${sysconfdir}/systemd/system/* \
"

do_install:append:smarcfimx6qp2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system
	
	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx6qp1g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx6q2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx6q2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
                ${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx6q1g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx6dl1g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx6solo() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx7d2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx7d() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcfimx7s() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcimx8mm2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcimx8mm4g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcimx8mp2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcimx8mp4g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:smarcimx8mp6g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:pitximx8mp2g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:pitximx8mp4g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}

do_install:append:pitximx8mp6g() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants
	install -m 0644 ${WORKDIR}/disable-serialgetty.service ${D}${systemd_unitdir}/system
	install -m 0755 ${WORKDIR}/disable-serialgetty.sh ${D}${systemd_unitdir}/system

	ln -sf ${systemd_unitdir}/system/disable-serialgetty.service \
		${D}${sysconfdir}/systemd/system/sysinit.target.wants/disable-serialgetty.service
}
