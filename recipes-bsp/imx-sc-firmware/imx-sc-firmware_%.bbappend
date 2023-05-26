FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SC_FIRMWARE_NAME:smarcimx8qm4g = "mx8qm-smarc4g-scfw-tcm.bin"
SC_FIRMWARE_NAME:smarcimx8qm8g = "mx8qm-smarc8g-scfw-tcm.bin"

SC_MX_FAMILY ?= "INVALID"
SC_MX8_FAMILY:mx8qm-nxp-bsp = "qm"
SC_MACHINE_NAME = "mx8${SC_MX8_FAMILY}_b0"

SCFW_BRANCH = "8qm-1.13.0"
SRCREV = "9dfbbced92bfe7e1445d766cc93bc2e81943a59f"

SRC_URI += " \
    git://git@git.embedian.com/developer/imx-sc-firmware.git;protocol=ssh;branch=${SCFW_BRANCH}; \
    https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2;name=gcc-arm-none-eabi \
"

SRC_URI[gcc-arm-none-eabi.md5sum] = "f55f90d483ddb3bcf4dae5882c2094cd"
SRC_URI[gcc-arm-none-eabi.sha256sum] = "fb31fbdfe08406ece43eef5df623c0b2deb8b53e405e2c878300f7a1f303ee52"

unset do_compile[noexec]

do_compile:smarcimx8qm4g() {
    export TOOLS=${WORKDIR}
    cd ${WORKDIR}/git/
    oe_runmake clean-${SC_MX8_FAMILY}
    oe_runmake ${SC_MX8_FAMILY} R=B0 B=smarc_4g V=1
    cp ${WORKDIR}/git/build_${SC_MACHINE_NAME}/scfw_tcm.bin ${S}/${SC_FIRMWARE_NAME}
}

do_compile:smarcimx8qm8g() {
    export TOOLS=${WORKDIR}
    cd ${WORKDIR}/git/
    oe_runmake clean-${SC_MX8_FAMILY}
    oe_runmake ${SC_MX8_FAMILY} R=B0 B=smarc_8g V=1
    cp ${WORKDIR}/git/build_${SC_MACHINE_NAME}/scfw_tcm.bin ${S}/${SC_FIRMWARE_NAME}
}
