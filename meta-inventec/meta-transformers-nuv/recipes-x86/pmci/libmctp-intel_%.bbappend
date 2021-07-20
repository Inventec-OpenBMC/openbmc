FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_transformers-nuv := "git://github.com/Nuvoton-Israel/libmctp.git"
SRCREV_transformers-nuv := "09a11109c694b3c690370f640e84983ae6e2db7e"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"


