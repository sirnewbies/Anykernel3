# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string= cascom-5.10 KSU by ghost
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
supported.versions=13 - 14.1
'; } # end properties

# shell variables
slot=$(find_slot);
block=/dev/block/bootdevice/by-name/boot$slot;
is_slot_device=1;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
split_boot;

## Selinux Permissive
#patch_cmdline androidboot.selinux androidboot.selinux=permissive

# migrate from /overlay to /overlay.d to enable SAR Magisk
if [ -d $ramdisk/overlay ]; then
  rm -rf $ramdisk/overlay;
fi;

# end ramdisk changes

flash_boot;
## end install

sleep 3
ui_print ""
ui_print "kernel installed successfully"
