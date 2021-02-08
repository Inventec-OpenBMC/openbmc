RDEPENDS_${PN}-dbus_remove += " \
        python-dbus \
        python-xml \
        python-json \
        python-pickle \
        "
RDEPENDS_${PN}-dbus += " \
        ${PYTHON_PN}-dbus \
        ${PYTHON_PN}-xml \
        ${PYTHON_PN}-json \
        ${PYTHON_PN}-pickle \
        "

RDEPENDS_${PN} += " \
        ${PN}-ns \
        ${PN}-dbus \
        python-subprocess \
        python-dbus \
        "
RDEPENDS_${PN}_remove += " \
        python-subprocess \
        python-dbus \
        "
RDEPENDS_${PN} += " \
        ${PYTHON_PN}-dbus \
        "

