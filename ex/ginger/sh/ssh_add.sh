#!/bin/bash

# cd this shell's current directory
SHELL_DIR=$(cd "$(dirname "$0")";pwd)
echo "SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

mkdir -p ~/.ssh

echo "** add my bc/win's ssh..."
cat ../res/id_rsa.pub.bc.win >> ~/.ssh/authorized_keys

echo "** add my bc/ubuntu's ssh..."
cat ../res/id_rsa.pub.bc.ubuntu >> ~/.ssh/authorized_keys

echo "** add my bc2's ssh..."
cat ../res/id_rsa.pub.bc2 >> ~/.ssh/authorized_keys

echo "** add my pc's ssh..."
cat ../res/id_rsa.pub.pc >> ~/.ssh/authorized_keys

echo "** add my pc2's ssh..."
cat ../res/id_rsa.pub.pc2 >> ~/.ssh/authorized_keys
