#!/bin/bash

#
# Generate usb camera rules for patrol3.0
# to distinguish two same cameras on ccu, such as:
#
# Bus 001 Device 007: ID 0bda:3035 Realtek Semiconductor Corp.
# Bus 001 Device 005: ID 0bda:3035 Realtek Semiconductor Corp.
#

VENDOR_ID=0bda
PRODUCT_ID=3035
RULES_DIR=/etc/udev/rules.d
RULES_FILE_NAME=66-usb-camera-sides.rules

# check if rules file exist
RULES_FILE=$RULES_DIR/$RULES_FILE_NAME
if [ -f "$RULES_FILE" ]; then
    echo "** rules file '$RULES_FILE' already exist."
else
    # retrieve device number
    CAMERA_ID=$VENDOR_ID:$PRODUCT_ID
    DEV_NUM_RAW1=`lsusb | grep $CAMERA_ID | awk '{print $4}' | sed -n '1p' | sed -r 's/0*([0-9])/\1/'`
    DEV_NUM_RAW2=`lsusb | grep $CAMERA_ID | awk '{print $4}' | sed -n '2p' | sed -r 's/0*([0-9])/\1/'`
    
    DEV_NUM1=${DEV_NUM_RAW1%?}
    DEV_NUM2=${DEV_NUM_RAW2%?}
    
    # echo "** DEV_NUM1=[$DEV_NUM1]"
    # echo "** DEV_NUM1=[$DEV_NUM2]"
    
    # write rules to file
    RULE1="SUBSYSTEMS==\"usb\", KERNEL==\"video*\", ATTRS{devnum}==\"$DEV_NUM1\", ATTRS{idProduct}==\"$PRODUCT_ID\", ATTRS{idVendor}==\"$VENDOR_ID\", SYMLINK+=\"video-side1\""
    RULE2="SUBSYSTEMS==\"usb\", KERNEL==\"video*\", ATTRS{devnum}==\"$DEV_NUM2\", ATTRS{idProduct}==\"$PRODUCT_ID\", ATTRS{idVendor}==\"$VENDOR_ID\", SYMLINK+=\"video-side2\""
    echo $RULE1 > ~/$RULES_FILE_NAME
    echo $RULE2 >> ~/$RULES_FILE_NAME
    sudo cp ~/$RULES_FILE_NAME $RULES_DIR
    
    # take rules effect
    sudo udevadm trigger
fi
