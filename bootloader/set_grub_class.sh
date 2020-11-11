#!/bin/bash
#
# Alters the 'grub_class' to 'fedora' for BootLoaderSpec files of Fedora kernels.
# This should allow GRUB themes to display the correct Fedora icon.
# 
# WARNING: ALTERING BOOTLOADER FILES COULD PREVENT THE SYSTEM TO BOOT
# USE AT OWN RISK
#
# Documentation:
# - https://fedoraproject.org/wiki/Changes/BootLoaderSpecByDefault
# - https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
# - https://systemd.io/BOOT_LOADER_SPECIFICATION/
#

LOADER_DIR='/boot/loader/entries'  # directory hosting bootloader entries (BLS config files)
TARGET_FILENAMES='*fc3[2-3]*.conf' # wildcard to match Fedora 32 and Fedora 33 kernel entries
SOURCE_CLASS='kernel'              # 'grub_class' to modify
TARGET_CLASS='fedora'              # 'grub_class' to set (use 'Linux' for a more generic icon)

echo "Changing 'grub_class ${SOURCE_CLASS}' to 'grub_class ${TARGET_CLASS}' in ${LOADER_DIR}..."

for bootentry in ${LOADER_DIR}/${TARGET_FILENAMES}; do
    echo "Backup and edit ${bootentry}...";
    cp ${bootentry} ${bootentry}.bak
    sed -i 's/grub_class '${SOURCE_CLASS}'/grub_class '${TARGET_CLASS}'/' ${bootentry}
done

echo "Done! Run 'grub2-mkconfig' to regenerate grub.cfg"
echo "To reverse: swap SOURCE_CLASS with TARGET_CLASS and re-run."
echo "Backup files have been created and can be restored at any time."
