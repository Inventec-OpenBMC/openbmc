FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


DISTRO_FEATURES += "ipmi-fru"

SRC_URI += "file://Goldentalon.json"
SRC_URI += "file://blacklist.json"
SRC_URI += "file://GoldentalonFan.json"
SRC_URI += "file://GoldentalonEvent.json"


SRC_URI_append += " file://0001-Add-a-writable-dbus-interface.patch \
                    file://0002-Fix-dbus-probe-conditions.patch\
                  "

do_install_append() {
    install -d 0755 ${D}/usr/share/entity-manager/configurations
    rm  -rf ${D}/usr/share/entity-manager/configurations/*.json
    install -m 0644 ${WORKDIR}/Goldentalon.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/blacklist.json ${D}/usr/share/entity-manager/blacklist.json
    install -m 0644 ${WORKDIR}/GoldentalonFan.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/GoldentalonEvent.json ${D}/usr/share/entity-manager/configurations
}

