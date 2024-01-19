#!/bin/bash

SOURCE_DIR=../src

MODULE_NAMES=()
MODULE_URLS=()
MODULE_BRANCHES=()

# --------------------------------------------------------------------------------

function touch_dir_and_enter()
{
    if [ ! -d "$1" ];then
        echo "***create dir $1..."
        mkdir $1
    fi
    cd $1
}

function add_module()
{
    MODULE_NAMES[${#MODULE_NAMES[@]}]=$1
    MODULE_URLS[${#MODULE_URLS[@]}]=$2
    MODULE_BRANCHES[${#MODULE_BRANCHES[@]}]=$3
}

# --------------------------------------------------------------------------------

#
# Available Modules
#
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/cr-common -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/cr-controllers -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/cr-interfaces -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/cr-messages -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/cr-tools -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/ginger_description -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/ginger_moveit_config -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/head_camera -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/robot_analyzer -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/robot_animation -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/robot_auto_homing -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/robot_engine -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/robot_grasping -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/robot_dynamic -b nx441_dev
# git clone ssh://tom.li@10.11.35.102:29418/CR-DICS/third_party -b nx441_dev

# git clone ssh://tom.li@10.11.35.102:29418/CCU/Ginger/realsense2_cam -b ginger102
# git clone ssh://tom.li@10.11.35.102:29418/CCU/Ginger/ginger_manager -b ginger102
# git clone ssh://tom.li@10.11.35.102:29418/CCU/Ginger/ginger_msgs -b ginger102
# git clone ssh://tom.li@10.11.35.102:29418/CCU/Ginger/action_service -b ginger102
# git clone ssh://tom.li@10.11.35.102:29418/CCU/Ginger/ginger_algorithmsrv -b ginger102

add_module "cr-common" "CR-DICS" "nx441_dev"
add_module "cr-controllers" "CR-DICS" "nx441_dev"
add_module "cr-interfaces" "CR-DICS" "nx441_dev"
add_module "cr-messages" "CR-DICS" "nx441_dev"
add_module "cr-tools" "CR-DICS" "nx441_dev"
add_module "ginger_description" "CR-DICS" "nx441_dev"
add_module "ginger_moveit_config" "CR-DICS" "nx441_dev"
add_module "head_camera" "CR-DICS" "nx441_dev"
add_module "robot_analyzer" "CR-DICS" "nx441_dev"
add_module "robot_animation" "CR-DICS" "nx441_dev"
add_module "robot_auto_homing" "CR-DICS" "nx441_dev"
add_module "robot_engine" "CR-DICS" "nx441_dev"
add_module "robot_grasping" "CR-DICS" "nx441_dev"
add_module "robot_dynamic" "CR-DICS" "nx441_dev"
add_module "third_party" "CR-DICS" "nx441_dev"

add_module "realsense2_cam" "CCU/Ginger" "ginger102"
add_module "ginger_manager" "CCU/Ginger" "ginger102"
add_module "ginger_msgs" "CCU/Ginger" "ginger102"
add_module "action_service" "CCU/Ginger" "ginger102"
add_module "ginger_algorithmsrv" "CCU/Ginger" "ginger102"

# --------------------------------------------------------------------------------

module_num=${#MODULE_NAMES[*]}
echo ""
echo "--module number: ${module_num}"

touch_dir_and_enter $SOURCE_DIR

# for item in ${modules[*]}
# do
#     echo $item
# done
for (( k=0; k<$module_num; k++ ))
do
    module_dir=${MODULE_NAMES[$k]}
    module_url="${MODULE_URLS[$k]}/${MODULE_NAMES[$k]} -b ${MODULE_BRANCHES[$k]}"
    echo ""
    if [ ! -d "$module_dir" ];then
        echo "#$(($k+1)): git clone $module_url..."
        git clone ssh://tom.li@10.11.35.102:29418/$module_url
    else
        echo "#$(($k+1)): git update of $module_dir..."
        cd $module_dir
        git pull --rebase
        cd ..
    fi
done

echo ""
echo "--update over, following are your modules:"
ls -l $SOURCE_DIR
echo ""
echo "--module number: ${module_num}"
echo "--total size: `du -sh $SOURCE_DIR/ | awk '{print $1}'`"

echo ""
