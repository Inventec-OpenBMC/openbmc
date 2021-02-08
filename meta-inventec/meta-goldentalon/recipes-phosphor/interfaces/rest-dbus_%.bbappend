DEPENDS_remove_class-target = " python"
DEPENDS_append_class-target = " python3"

RDEPENDS_${PN}_remove += " \
        python-netserver \
        python-json \
        python-dbus \
        python-xml \
       "
RDEPENDS_${PN} += "\
        ${PYTHON_PN}-netserver \
        ${PYTHON_PN}-json \
        ${PYTHON_PN}-dbus \
        ${PYTHON_PN}-xml \
        "
