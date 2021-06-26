DEPENDS_remove_class-target = " python"
DEPENDS_append_class-target = " python3"

RDEPENDS_${PN}_remove += "\
        python-dbus \
        python-pygobject \
        python-subprocess \
        "
RDEPENDS_${PN} += "\
        ${PYTHON_PN}-dbus \
        ${PYTHON_PN}-pygobject \
        "
