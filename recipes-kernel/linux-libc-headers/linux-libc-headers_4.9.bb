require recipes-kernel/linux-libc-headers/linux-libc-headers.inc

PR_append = ".smarc2"

BRANCH = "smarct4x-processor-sdk-04.01.00.06"

SRCREV = "ee02bdddf749294ed31b0ab77c1ee6bd23b7a6f2"

SRC_URI = "${EMB_KERNEL_MIRROR};protocol=ssh;branch=${BRANCH} \
"
S = "${WORKDIR}/git"
