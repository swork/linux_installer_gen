#! /bin/bash -x
set -e

$(dirname $0)/recopy-mini.sh
sudo rm ~/cdm/initrd.gz
cd ~/rdm/
sudo sh -c 'find . | cpio --create --format="newc" | gzip -9 > ../cdm/initrd.gz'
cd ~/cdm/
sudo mkisofs -o ../lx/fester-vm-installer.iso -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux.bin -c boot.cat .
