# Android fstab file.
# <src>                                         <mnt_point>  <type>  <mnt_flags and options>  <fs_mgr_flags>
# The filesystem that contains the filesystem checker binary (typically /system) cannot
# specify MF_CHECK, and must come before any filesystems that do specify MF_CHECK

/dev/block/platform/msm_sdcc.1/by-name/system       /system         ext4    ro,barrier=1                                                                   wait,recoveryonly
/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           ext4    rw,nosuid,nodev,noatime,noauto_da_alloc,nobarrier                              wait,check,formattable,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata
/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          ext4    rw,noatime,nosuid,nodev,barrier=1,data=ordered                                 wait,check,formattable
/dev/block/platform/msm_sdcc.1/by-name/persist      /persist        ext4    rw,nosuid,nodev,noatime,no_sehash_xattr,barrier=1                              wait,check,notrim
/dev/block/platform/msm_sdcc.1/by-name/modem        /firmware       vfat    ro,uid=1000,gid=1000,dmask=227,fmask=337,context=u:object_r:radio_efs_file:s0  wait
/dev/block/platform/msm_sdcc.1/by-name/boot         /boot           emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/recovery     /recovery       emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/misc         /misc           emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/modem        /radio          emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/sbl1         /sbl1           emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/sbl2         /sbl2           emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/sbl3         /sbl3           emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/tz           /tz             emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/rpm          /rpm            emmc    defaults                                                                       defaults
/dev/block/platform/msm_sdcc.1/by-name/aboot        /aboot          emmc    defaults                                                                       defaults
/dev/block/zram0                                    none            swap    defaults                                                                       zramsize=50%,max_comp_streams=4,swapprio=10,notrim
