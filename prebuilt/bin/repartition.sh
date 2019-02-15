#!/sbin/sh
# Copyright (c) 2019, The LineageOS Project
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the LineageOS Project nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

valid_table=0
repartition=0

parted="/tmp/parted"

# Check for /data partition size
$parted /dev/block/mmcblk0p23 unit b p quit -> /tmp/sizecheck

if grep "6189744128B" /tmp/sizecheck > /dev/null || grep "14129561600B" /tmp/sizecheck > /dev/null
then
	valid_table=1
else
	valid_table=0
fi

if [ $valid_table == 0 ]
then
	exit 0
fi

# Check for /cache partition size
$parted /dev/block/mmcblk0p22 unit b p quit -> /tmp/sizecheck

if grep "587202560B" /tmp/sizecheck > /dev/null # original
then
	valid_table=1
elif grep "134217728B" /tmp/sizecheck > /dev/null # modified
then
	valid_table=1
else
	valid_table=0
fi

if [ $valid_table == 0 ]
then
	exit 0
fi

# Check for /system partition size
$parted /dev/block/mmcblk0p21 unit b p quit -> /tmp/sizecheck

if grep "880803840B" /tmp/sizecheck > /dev/null # original
then
	valid_table=1
	repartition=1
elif grep "1333788672B" /tmp/sizecheck > /dev/null # modified
then
	valid_table=1
	repartition=0
else
	valid_table=0
fi

if [ $valid_table == 0 ]
then
	exit 0
fi

if [ $repartition == 1 ]
then
	echo "Resizing system and cache partitions..."

	umount /system
	umount /cache

	$parted /dev/block/mmcblk0 rm 21
	$parted /dev/block/mmcblk0 rm 22
	$parted /dev/block/mmcblk0 mkpart primary 159383552B 1493172223B
	$parted /dev/block/mmcblk0 name 21 system
	$parted /dev/block/mmcblk0 mkpart primary 1493172224B 1627389951B
	$parted /dev/block/mmcblk0 name 22 cache

	echo "Formatting system and cache partitions..."
	mke2fs -b 4096 -T ext4 /dev/block/mmcblk0p21
	mke2fs -b 4096 -T ext4 /dev/block/mmcblk0p22

	ln -sf /dev/block/mmcblk0p21 system
	ln -sf /dev/block/mmcblk0p22 cache

	mount /system
	mount /cache

	echo "Done!"

	# Just reboot recovey for now until better solution to reread partition table
	reboot recovery
fi

exit 1
