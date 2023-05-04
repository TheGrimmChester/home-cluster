#!/bin/bash

#NAME=plex IMAGE=csi-vol-613d147d-f50e-437b-a102-23ff9b29b954 ./mount_rbd.sh
#NAME=home-assistant IMAGE=csi-vol-8d16312f-5717-4c49-9253-403ecc603c36 ./mount_rbd.sh
#NAME=teslamate-grafana IMAGE=csi-vol-5468a1c6-ceab-46e2-8b02-36eb4ee3c4b5 ./mount_rbd.sh
#NAME=mealie IMAGE=csi-vol-621f564d-170e-4c12-b40a-6959cafbd401 ./mount_rbd.sh
#NAME=grocy IMAGE=csi-vol-0c7c9441-b74a-4151-a6cf-467b00ddb140 ./mount_rbd.sh
#NAME=sickchill IMAGE=csi-vol-34b6003d-ed7b-4307-8175-8970d96e5d12 ./mount_rbd.sh
#NAME=zigbee IMAGE=csi-vol-ef2ce8a3-9d4f-40d5-9e0e-f578a33abfa2 ./mount_rbd.sh

kubectl scale -n media statefulset $NAME --replicas=0

sudo umount /tmp/rbd_$NAME || true
sudo rbd unmap /dev/rbd/ceph-blockpool/$IMAGE || true
echo "Creating path /tmp/rbd_$NAME"
sudo mkdir -p /tmp/rbd_$NAME || true
RBD=$(sudo rbd -c /etc/ceph/ceph.conf -p ceph-blockpool map $IMAGE)
echo "Mounting $RBD to rbd_$NAME"
sudo mount $RBD /tmp/rbd_$NAME
read -p "Press enter to continue"
sudo umount /tmp/rbd_$NAME
sudo rbd unmap $RBD
kubectl scale -n media statefulset $NAME --replicas=1
