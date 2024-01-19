touchpad_id=$(xinput | grep 'Touchpad' | awk -F'id=' '{print $2}' | awk '{print $1}')
echo "find Touchpad ID $touchpad_id, enalbe it..."
xinput --enable $touchpad_id
