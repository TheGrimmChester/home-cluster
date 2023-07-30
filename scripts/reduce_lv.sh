lvreduce -L -100G /dev/ubuntu-vg/rook-ceph
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
lsblk /dev/sda
vgdisplay
resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
