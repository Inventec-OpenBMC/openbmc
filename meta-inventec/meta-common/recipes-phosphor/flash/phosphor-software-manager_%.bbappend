FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0001-add-cpld-image-upload-flow.patch \
            file://0002-add-bios-image-upload-flow.patch \
            file://0003-Fix-BIOS-version-is-null-issue.patch \
           "
#add cpld service
SYSTEMD_SERVICE_${PN}-updater += " \
   obmc-cpld-update@.service \
"
#enable host-bios-update feature
PACKAGECONFIG[flash_bios] = "-Dhost-bios-upgrade=enabled"
PACKAGECONFIG_append = "flash_bios"


