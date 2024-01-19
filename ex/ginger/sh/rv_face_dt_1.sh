#!/bin/bash

rosservice call /robot_vision/ctrl "data: 'face_dt:1'"
cx fd off
cx fd on
