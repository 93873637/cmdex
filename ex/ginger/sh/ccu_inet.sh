#!/bin/bash

IP_SET=10.11.32.74
echo "** IP_SET = $IP_SET"

IF_SET=eth0
echo "** IF_SET = $IF_SET"

set -v
sudo ifconfig $IF_SET:1 $IP_SET netmask 255.255.255.0 up
sudo route add default gw 10.11.32.254
netstat -rn
ping www.baidu.com
set +v

# --generally, our ccu is 192.168.1.200, can't access internet.
# --but when connect ccu by cable to company's LAN which can access internet,
# --we can config a temporary net adapter to let it surface,
# --then you can use sudo apt-get to install some software freely.
# --Steps:
# 1. connect ccu with LAN(10.11.33.*) by cable to switch(TP-LINK).
# 2. see network info(ip address, gateway) or your LAN PC:
#    $ ifconfig
#    enp0s31f6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#        inet 10.11.33.72  netmask 255.255.255.0  broadcast 10.11.33.255
#        ...
#    $ netstat -nr
#    Kernel IP routing table
#    Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
#    0.0.0.0         10.11.33.254    0.0.0.0         UG        0 0          0 enp0s31f6
#    ..
#    here we got our LAN ip is 10.11.33.72, gateway is 10.11.33.254.
# 3. find an unused ipaddress on LAN by ping failed(such as 10.11.33.77)
# 4. on ccu, add virtual net adapter by ifconfig:
# sudo ifconfig eth0:1 10.11.32.74 netmask 255.255.255.0 up
# 5. on ccu, add gateway:
# sudo route add default gw 10.11.32.254
# 6. then you can connect to internet by test:
#    $ ping www.baidu.com

# NOTE:
# after using, the temporay net adapter may block your ros program,
# remove it after sudo download over.
# $ sudo ifconfig eth0:1 down
# $ sudo route del default gw 10.11.33.254
# $ netstat -rn
