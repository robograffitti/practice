cmake_minimum_required(VERSION 2.8.3)

# String Equal
if($ENV{ROS_DISTRO} STREQUAL "indigo")
  set(PROJECT_NAME test_nodelet)
else()
  set(PROJECT_NAME test_nodelet)
endif() # if else endif

project(${PROJECT_NAME})

if($ENV{ROS_DISTRO} STREQUAL "groovy")
  # update package.xml, in groovy we need to add pcl to package.xml
  execute_process(COMMAND sed -i s@<run_depend>pcl_ros</run_depend>@<run_depend>pcl_ros</run_depend><run_depend>pcl</run_depend>@g ${PROJECT_SOURCE_DIR}/package.xml)
  execute_process(COMMAND sed -i s@<build_depend>pcl_ros</build_depend>@<build_depend>pcl_ros</build_depend><build_depend>pcl</build_depend>@g ${PROJECT_SOURCE_DIR}/package.xml)
endif($ENV{ROS_DISTRO} STREQUAL "groovy")

if($ENV{ROS_DISTRO} STREQUAL "groovy")
  # execute_process(echo "build with ros indigo.")
else()
  # execute_process(echo "hoge")
endif()

if($ENV{ROS_DISTRO} STREQUAL "groovy")
  set(PCL_MSGS pcl)
pelse()
  set(PCL_MSGS pcl_msgs) ## hydro and later
endif()

find_package(catkin REQUIRED COMPONENTS
  pcl_conversions pcl_ros
  roscpp nodelet
  sensor_msgs geometry_msgs
  message_generation genmsg
  eigen_conversions
  tf_conversions tf2 tf
  # dynamic_reconfigure
  # image_transport
  # cv_bridge
  # image_geometry
  # octomap_server octomap_ros octomap_msgs
  # kdl_parser kdl_conversions
  # jsk_recognition_utils jsk_recognition_msgs
  # jsk_topic_tools
  )

if(NOT $ENV{ROS_DISTRO} STREQUAL "groovy")
  find_package(PCL REQUIRED)
endif(NOT $ENV{ROS_DISTRO} STREQUAL "groovy")

# find_package(OpenMP)
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")

find_package(PkgConfig)
pkg_check_modules(yaml_cpp yaml-cpp REQUIRED)
IF(${yaml_cpp_VERSION} VERSION_LESS "0.5.0")
## indigo yaml-cpp : 0.5.0 /  hydro yaml-cpp : 0.3.0
  add_definitions("-DUSE_OLD_YAML")
ENDIF()

# add_service_files(
#   # hoge
#   )

# generate_dynamic_reconfigure_options(
#   # hoge
#   )

find_package(OpenCV REQUIRED core imgproc)

include_directories(include ${catkin_INCLUDE_DIRS} ${OpenCV_INCLUDE_DIRS} ${PCL_INCLUDE_DIRS})

# macro(test_nodelet _nodelet_cpp _nodelet_class _single_nodelet_exec_name)
#   jsk_nodelet(${_nodelet_cpp} ${_nodelet_class} ${_single_nodelet_exec_name}
#     jsk_pcl_nodelet_sources jsk_pcl_nodelet_executables)
# endmacro(test_nodelet _nodelet_cpp _nodelet_class _single_nodelet_exec_name)
# test_nodelet(src/test_nodelet.cpp "test_nodelet/TestNodelet" "test_nodelet")

catkin_package(
    LIBRARIES test_nodelet # xml name
    DEPENDS pcl
    CATKIN_DEPENDS pcl_ros message_runtime ${PCL_MSGS} sensor_msgs geometry_msgs
    INCLUDE_DIRS include
    )

## Create the nodelet tutorial library
add_library(test_nodelet src/TestNodeletClass.cpp)
target_link_libraries(test_nodelet ${catkin_LIBRARIES})
if(catkin_EXPORTED_LIBRARIES)
  add_dependencies(test_nodelet ${catkin_EXPORTED_LIBRARIES})
endif()

## Mark the nodelet library for installations
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})
install(TARGETS test_nodelet
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

## Mark other files for installation (e.g. launch and bag files, etc.)
install(FILES test_nodelet.xml test_nodelet.launch test_default.yaml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
