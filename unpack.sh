#! /bin/bash -x
set -e
# To be run on a Linux VM with ~/lx a symlink into a host shared
# folder, at directory fester/setup/linux_installer_gen.

sudo rm -rf ~/cd ~/rd
mkdir ~/cd ~/rd

(cd ~/cd && sudo bsdtar -xf ~/lx/ubuntu-13.04-server-i386.iso)

(cd ~/rd && gunzip -c ../cd/install/initrd.gz | sudo cpio --extract --preserve)
$(dirname $0)/recopy.sh
