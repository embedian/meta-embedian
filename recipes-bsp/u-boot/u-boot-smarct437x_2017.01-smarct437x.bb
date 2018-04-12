require u-boot-smarc.inc

COMPATIBLE_MACHINE = "smarct437x"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

PV = "2017.01-smarct437x"
PR = "r0+gitr${SRCPV}"

SRC_URI = "${EMB_UBOOT_MIRROR};protocol=ssh;branch=${BRANCH}"

BRANCH = "v2017.01-smarct4x"

SRCREV = "cdf3eec481bc889feed3356a7d3a2f0be62c18a7"

S = "${WORKDIR}/git"

UBOOT_SUFFIX = "img"

# If TEST# pin is shunt #
# SPL_BINARY = "MLO"
SPL_BINARY = "MLO.byteswap"
UBOOT_SPI_BINARY = "u-boot.img"
SPL_UART_BINARY = "u-boot-spl.bin"
