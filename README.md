# visnet-docker
Docker files needed to build images for visnet/px4_sitl simulation in ROS2 and Gazebo

The `./work` directory setup (Need to manualy clone each repo, probably will set up submodules soon)
```
work/
┣ px4/
┣ ros2_ws/
┃ ┗ src/
┃   ┣ px4_msgs/
┃   ┣ ros_gz/
┃   ┗ visnet/
┗ .gitignore
```

### Build and run
To build the image

`docker build ./`

To run multiple drones

`docker compose up`

To access the shell of each service, in two different terminals run

Terminal 1: `docker exec -it visnet-visnet_1-1 terminator`\
Terminal 2: `docker exec -it visnet-visnet_2-1 terminator`

To start px4_sitl and ros2 offboard control, split each terminator into 3 panels and run

1. `cd px4 && make px4_sitl` to build px4_sitl first. (This only need to be built once in one of the container shells)\
`PX4_SYS_AUTOSTART=4001 ./build/px4_sitl_default/bin/px4 -i 1` to start px4_sitl instance 1 with x500 in gz-garden.\
In the other container shell start with `-i 2` 

2. `MicroXRCEAgent udp4 -p 8888` to start DDS agent for communication with ROS2\

3. `cd ros2_ws && colcon build` to build ros2 packages neccessary for px4-ros-gz communications\
then `python3 ros2_ws/src/visnet/scripts/offboard_control.py` to start the offboard control example.

### Environment Variables
- `PX4_GZ_MODEL` Name of the px4 vehicle model to spawn in gz
- `PX4_GZ_MODEL_POSE` Spawn pose of the vehicle model, must used with `PX4_GZ_MODEL`
- `PX4_MICRODDS_NS` Namespace assigned to the sitl vehicle, normally associated with px4 instances, but can be set mannually
- `ROS_DOMAIN_ID` Separate each container into its own domain (Is it still necessary since each SITL instance has a unique namespace?)
  
