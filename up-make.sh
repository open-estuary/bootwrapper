#!/bin/sh
cd ..
PATH_P650=$(pwd)
echo $PATH_P650

cd $PATH_P650/boot-wrapper

make clean
rm filesystem.cpio.gz

cd $PATH_P650/fs/
rm filesystem.cpio.gz

cd $PATH_P650/linux-next/
./scripts/dtc/dtc -O dtb ../arm-dts/p650_dts/64-bit-address/new-p650-a15x4.dts > $PATH_P650/boot-wrapper/p650-a15x4.dtb

cd $PATH_P650/linux-next
rm ./arch/arm/boot/zImage

cd $PATH_P650/boot-wrapper/

make

echo "Building host fs...."
cd $PATH_P650/fs/sysroot-650
./host-mk-fs.sh
echo "Done"
cd -

sleep 1
cat $PATH_P650/boot-wrapper/p650-a15x4.dtb >> $PATH_P650/linux-upstream/arch/arm/boot/zImage
sleep 3
make

./objcopy-sh
