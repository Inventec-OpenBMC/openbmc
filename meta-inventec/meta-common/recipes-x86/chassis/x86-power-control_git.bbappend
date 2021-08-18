FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit cmake systemd

SRC_URI += "file://0001-Add-RequestedPowerIntervalMs-property.patch \
            file://0002-Add-host-power-off-and-host-power-on-hook-service.patch \
            file://host-power-off.service \
            file://host-power-on.service \
            file://host-power-off.target \
            file://host-power-on.target \
           "

SYSTEMD_SERVICE_${PN} += "host-power-off.service \
                          host-power-on.service \
                          host-power-off.target \
                          host-power-on.target"
