#!/bin/bash
# Kernel build script by Suhyuk Park (NKS, nks15)
# + Contact @nks15 via Telegram if you have suggestions, bugs, etc.
#
# Me0wzz-NKS Kernel for SM-J510(K)(S)
# By Me0wzz
#

echo "###############################################"
echo "Me0wzz-NKS Kernel by Me0wzz and for SM-J510(K)(S)"
echo "Build script by Suhyuk Park (NKS, nks15)"
echo "###############################################"

# Set up toolchain if not exist, I am currently using @khadas's!
export TOOLCHAIN=/opt/toolchains
export TOOLCHAIN_BUILD=android_prebuilts_gcc_linux-x86_arm_arm-eabi-4.8

if [ ! -e "$TOOLCHAIN" ]; then
   mkdir $TOOLCHAIN
fi
if [ ! -e "$TOOLCHAIN/$TOOLCHAIN_BUILD" ]; then
   git clone https://github.com/khadas/android_prebuilts_gcc_linux-x86_arm_arm-eabi-4.8.git -b Vim $TOOLCHAIN/$TOOLCHAIN_BUILD
fi

# Set up basic things.
export ARCH=arm
export LOCALVERSION=""
export CROSS_COMPILE=$TOOLCHAIN/$TOOLCHAIN_BUILD/bin/arm-eabi-

# Now let's build kernels :)
mkdir output
make -C $(pwd) O=output msm8916_sec_defconfig VARIANT_DEFCONFIG=msm8916_sec_j5xlte_defconfig SELINUX_DEFCONFIG=selinux_defconfig
make -j64 -C $(pwd) O=output
cp output/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
