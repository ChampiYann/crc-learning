#! /bin/bash

sudo yum update -y

sudo pvcreate /dev/$(sudo lsblk -d -o NAME -x HCTL | sed -n '2p')
sudo vgcreate uservg /dev/$(sudo lsblk -d -o NAME -x HCTL | sed -n '2p')
sudo lvcreate -L 1023GB -n userlv uservg
sudo mkfs.ext4 /dev/uservg/userlv

mkdir /home/yannr/.crc
sudo mount -t ext4 /dev/uservg/userlv /home/yannr/.crc

wget https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz