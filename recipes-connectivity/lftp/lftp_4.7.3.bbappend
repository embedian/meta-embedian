# Fix broken link due to the original repo move branch from master to main

SRC_URI = "\
    http://lftp.yar.ru/ftp/lftp-${PV}.tar.gz \
            file://fix-gcc-6-conflicts-signbit.patch \
	"
