FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:smarcimx8mm2g = " \
	file://0001-imx8mm-atf-uart4.patch \
"

SRC_URI:append:smarcimx8mm4g = " \
        file://0001-imx8mm-atf-uart4.patch \
"
