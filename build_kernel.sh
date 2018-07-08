#!/bin/bash
# Me0wzz-NKS Kernel Build Script by NKS (nks15)
#
# Me0wzz-NKS Kernel for SM-J510(K)(S)
# + Contact me if you have suggestions, bug, etc.
#

echo "Me0wzz-NKS Kernel Build Script by NKS (nks15) Build and Edit by Me0wzz"
echo " "
echo "Me0wzz-NKS Kernel for SM-J510(K)(S) (Script 1.0)"
echo "+ Contact me if you have suggestions, bug, etc."

# Set up toolchain if not exist, We are currently using @khadas's
export TOOLCHAIN=/opt/toolchains
export TOOLCHAIN_BUILD=android_prebuilts_gcc_linux-x86_arm_arm-eabi-4.8

if [ ! -e "$TOOLCHAIN" ]; then
   mkdir $TOOLCHAIN
fi
if [ ! -e "$TOOLCHAIN/$TOOLCHAIN_BUILD" ]; then
   git clone https://github.com/khadas/android_prebuilts_gcc_linux-x86_arm_arm-eabi-4.8.git -b Vim $TOOLCHAIN/$TOOLCHAIN_BUILD
fi

# Set up basic things
export ARCH=arm
export LOCALVERSION=""
export CROSS_COMPILE=$TOOLCHAIN/$TOOLCHAIN_BUILD/bin/arm-eabi-

# Now let's build kernels
mkdir output
make -C $(pwd) O=output msm8916_sec_defconfig VARIANT_DEFCONFIG=msm8916_sec_j5xlte_defconfig SELINUX_DEFCONFIG=selinux_defconfig
make -j64 -C $(pwd) O=output
cp output/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
