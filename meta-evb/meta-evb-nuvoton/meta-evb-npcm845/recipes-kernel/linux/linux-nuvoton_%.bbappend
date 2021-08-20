FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_evb-npcm845 = " \
  file://evb-npcm845.cfg \
  file://0001-dts-nuvoton-evb-npcm845-update-device-tree.patch \
  "
