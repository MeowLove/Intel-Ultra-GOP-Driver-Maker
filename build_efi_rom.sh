#!/bin/bash
git submodule update --init
source edksetup.sh
sed -i 's:^ACTIVE_PLATFORM\s*=\s*\w*/\w*\.dsc*:ACTIVE_PLATFORM       = OvmfPkg/OvmfPkgX64.dsc:g' Conf/target.txt
sed -i 's:^TARGET_ARCH\s*=\s*\w*:TARGET_ARCH           = X64:g' Conf/target.txt
sed -i 's:^TOOL_CHAIN_TAG\s*=\s*\w*:TOOL_CHAIN_TAG        = GCC5:g' Conf/target.txt
make -C BaseTools
build -DFD_SIZE_4MB -DDEBUG_ON_SERIAL_PORT=TRUE
cp Build/OvmfX64/DEBUG_GCC5/X64/PlatformGOPPolicy.efi Build/
cp Build/OvmfX64/DEBUG_GCC5/X64/IgdAssignmentDxe.efi Build/
cp ./BaseTools/Source/C/bin/EfiRom Build/
cd Build
ls
./EfiRom -e IntelGop_Ultra125H_22.0.1035.efi IgdAssignmentDxe.efi PlatformGOPPolicy.efi -f 0x8086 -i 0xffff -o cxt-ultra-125h-1035.rom
ls
./EfiRom -e IntelGop_Ultra125H_22.0.1041.efi IgdAssignmentDxe.efi PlatformGOPPolicy.efi -f 0x8086 -i 0xffff -o cxt-ultra-125h-1041.rom
ls
