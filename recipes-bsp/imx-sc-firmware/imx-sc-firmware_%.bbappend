FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
        file://${SC_FIRMWARE_NAME} \
"

do_deploy:prepend:smarcimx8qm4g () {
    cp ${WORKDIR}/${SC_FIRMWARE_NAME} ${S}/${SC_FIRMWARE_NAME}
}

do_deploy:prepend:smarcimx8qm8g () {
    cp ${WORKDIR}/${SC_FIRMWARE_NAME} ${S}${SC_FIRMWARE_NAME}
}
