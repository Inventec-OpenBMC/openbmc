FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRC_URI_append += " file://0001-Add-a-writable-dbus-interface.patch \
                    file://0002-Fix-dbus-probe-conditions.patch\
                  "

