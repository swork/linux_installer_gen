#! /bin/bash -x
set -e

sudo cp ~/lx/di.seed ~/rd/preseed.cfg
sudo sh -c '(cd ~/cd/isolinux && rm -f *.cfg *.hlp *.tr *.txt *.c32 *.jpg bootlogo langlist)'
sudo cp ~/lx/isolinux,isolinux.cfg ~/cd/isolinux/isolinux.cfg
sudo cp ~/lx/isolinux,txt.cfg ~/cd/isolinux/txt.cfg
