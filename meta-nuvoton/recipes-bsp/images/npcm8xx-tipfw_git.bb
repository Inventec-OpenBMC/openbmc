LICENSE = "CLOSED"

SRC_URI = " \
    file://arbel_tip_fw.bin \
    file://Kmt_TipFw_signed.bin \
"

S = "${WORKDIR}"

inherit deploy

do_deploy () {
	install -D -m 644 ${S}/arbel_tip_fw.bin ${DEPLOYDIR}/arbel_tip_fw.bin
    install -D -m 644 ${S}/Kmt_TipFw_signed.bin ${DEPLOYDIR}/Kmt_TipFw_signed.bin
}

addtask deploy before do_build after do_compile
