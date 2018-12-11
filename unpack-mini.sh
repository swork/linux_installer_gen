#! /bin/bash -x
set -e
# To be run on a Linux VM with ~/lx a symlink into a host shared
# folder, at directory fester/setup/linux_installer_gen.

sudo rm -rf ~/cdm ~/rdm
mkdir ~/cdm ~/rdm

# My download was called "mini.iso" so I renamed it. Not sure what you'll find.
(cd ~/cdm && sudo bsdtar -xf ~/lx/ubuntu-13.04-mini-i386.iso)

(cd ~/rdm && gunzip -c ../cdm/initrd.gz | sudo cpio --extract --preserve)
$(dirname $0)/recopy-mini.sh
