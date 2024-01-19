#!/bin/bash

rosservice call /robot_vision/ctrl "data: 'face_dt:0'"
cx fd off
cx fd on
