FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://master_write_read_white_list.json \
            file://dcmi_cap.json \
            file://dcmi_sensors.json \
            file://power_reading.json \
            file://dev_id.json \
           "

FILES_${PN} += " \
                ${datadir}/ipmi-providers/master_write_read_white_list.json \
                ${datadir}/ipmi-providers/dcmi_cap.json \
                ${datadir}/ipmi-providers/dcmi_sensors.json \
                ${datadir}/ipmi-providers/power_reading.json \
                ${datadir}/ipmi-providers/dev_id.json \
               "

do_install_append() {
    install -m 0644 -D ${WORKDIR}/master_write_read_white_list.json \
        ${D}${datadir}/ipmi-providers/master_write_read_white_list.json
    install -m 0644 -D ${WORKDIR}/dcmi_cap.json \
        ${D}/usr/share/ipmi-providers/dcmi_cap.json
    install -m 0644 -D ${WORKDIR}/dcmi_sensors.json \
        ${D}/usr/share/ipmi-providers/dcmi_sensors.json
    install -m 0644 -D ${WORKDIR}/power_reading.json \
        ${D}/usr/share/ipmi-providers/power_reading.json
    install -m 0644 -D ${WORKDIR}/dev_id.json \
        ${D}/usr/share/ipmi-providers/dev_id.json
}

