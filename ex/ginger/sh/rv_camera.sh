#!/bin/bash

rosservice call /robot_vision/ctrl "data: 'camera:on'"
rosservice call /robot_vision/ctrl "data: 'camera:off'"

rosservice call /robot_vision/ctrl "data: 'camera:backlight_control:on'"
rosservice call /robot_vision/ctrl "data: 'camera:backlight_control:off'"

rosservice call /robot_vision/ctrl "data: 'camera:color_roi:0,0,639,479'"

#############################################################################################

# function usage()
# {
#     echo "Usage:"
#     echo "$0 on|off|help|frame_rate|backlight_control|color_ae|color_expo|color_gain|color_roi"
# }

# function run_cmd()
# {
#     print_info "[CMD]:"
#     print_info $*
#     bash -c "$*"
# }

# if [ $# -eq 0 ]; then
#     usage $*
# fi

# function backlight_control()
# {
#     if [ $# -eq 2 ]; then
#         usage $*
#     fi
# }

# case $1 in
#   "on")
#     run_cmd "rosservice call /robot_vision/ctrl \"data: 'camera:backlight_control:on'\""
#     ;;
#   "off")
#     run_cmd "rosservice call /robot_vision/ctrl \"data: 'camera:backlight_control:off'\""
#     ;;
#   "frame_rate")
#     echo "You entered banana."
#     ;;
#   "backlight_control")
#     backlight_control $*
#     ;;
#   *)
#     usage
#     ;;
# esac

# if (cmd_opt == "open")
# {
#     rv_pipeline.set_cam_state(CamState::Open);
#     res.success = true;
#     return;
# }

# if (cmd_opt == "close")
# {
#     rv_pipeline.set_cam_state(CamState::Close);
#     res.success = true;
#     return;
# }

# if (cmd_opt == "frame_rate")
# {
#     CHECK_CMD_OPT_PARAM_NUM(3);
#     std::string frame_rate_str = trim(cmd_v[2]);
#     if (!is_num(frame_rate_str))
#     {
#         res.message = "param '";
#         res.message += cmd_v[2];
#         res.message += "' of ctrl cmd '";
#         res.message += cmd_v[0];
#         res.message += "' is not number";
#         res.success = false;
#         return;
#     }
#     res.success = rv_pipeline.set_frame_rate(atoi(frame_rate_str.c_str()), res.message);
#     return;
# }

# if (cmd_opt == "color_ae")
# {
#     CHECK_CMD_OPT_PARAM_NUM(3);
#     cmd_opt = trim(cmd_v[2]);
#     if (cmd_opt == "on")
#     {
#         rv_pipeline.set_color_ae(true);
#         res.success = true;
#         return;
#     }
#     if (cmd_opt == "off")
#     {
#         rv_pipeline.set_color_ae(false);
#         res.success = true;
#         return;
#     }
#     else
#     {
#         UNSUPPORTED_CMD_OPT;
#     }
# }

# if (cmd_opt == "backlight_control")
# {
#     CHECK_CMD_OPT_PARAM_NUM(3);
#     cmd_opt = trim(cmd_v[2]);
#     if (cmd_opt == "on")
#     {
#         rv_pipeline.enable_backlight_control(true);
#         res.success = true;
#         return;
#     }
#     if (cmd_opt == "off")
#     {
#         rv_pipeline.enable_backlight_control(false);
#         res.success = true;
#         return;
#     }
#     else
#     {
#         UNSUPPORTED_CMD_OPT;
#     }
# }

# if (cmd_opt == "color_expo")
# {
#     CHECK_CMD_OPT_PARAM_NUM(3);
#     string expo_str = trim(cmd_v[2]);
#     res.success = rv_pipeline.set_color_exposure(atof(expo_str.c_str()), res.message);
#     return;
# }

# if (cmd_opt == "color_gain")
# {
#     CHECK_CMD_OPT_PARAM_NUM(3);
#     string gain_str = trim(cmd_v[2]);
#     res.success = rv_pipeline.set_color_gain(atof(gain_str.c_str()), res.message);
#     return;
# }

# if (cmd_opt == "color_roi")
# {
#     CHECK_CMD_OPT_PARAM_NUM(3);
#     res.success = rv_pipeline.set_color_roi(trim(cmd_v[2]), res.message);
#     return;
# }
