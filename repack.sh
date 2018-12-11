#! /bin/bash -x
set -e

$(dirname $0)/recopy.sh
sudo rm ~/cd/install/initrd.gz
cd ~/rd/
sudo sh -c 'find . | cpio --create --format="newc" | gzip -9 > ../cd/install/initrd.gz'
cd ~/cd/
sudo mkisofs -o ../lx/fester-vm-installer-big.iso -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat .
