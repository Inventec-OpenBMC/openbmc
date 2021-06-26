DEPENDS_remove_class-target = " python"
DEPENDS_append_class-target = " python3"

RDEPENDS_${PN}_remove += "\
        python-dbus \
        python-compression \
        python-shell \
        python-pygobject \
        python-subprocess \
        python-io \
        "
RDEPENDS_${PN} += "\
        ${PYTHON_PN}-dbus \
        ${PYTHON_PN}-compression \
        ${PYTHON_PN}-shell \
        ${PYTHON_PN}-pygobject \
        ${PYTHON_PN}-io \
        "
