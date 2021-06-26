DEPENDS_remove_class-target = " python"
DEPENDS_append_class-target = " python3"


RDEPENDS_${PN} += "\
        python-dbus \
        python-pygobject \
        python-netclient \
        pyphosphor-dbus \
        "

RDEPENDS_${PN}_remove += "\
        python-dbus \
        python-pygobject \
        python-netclient \
        "
RDEPENDS_${PN} += "\
        ${PYTHON_PN}-dbus \
        ${PYTHON_PN}-pygobject \
        ${PYTHON_PN}-netclient \
        "
