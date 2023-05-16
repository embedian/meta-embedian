FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_deploy:prepend:smarcimx8qm4g () {
    cp ${WORKDIR}/${SC_FIRMWARE_NAME} ${S}
}

do_deploy:prepend:smarcimx8qm8g () {
    cp ${WORKDIR}/${SC_FIRMWARE_NAME} ${S}
}
