#include <pluginlib/class_list_macros.h>
#include "test_nodelet/TestNodeletClass.h"

PLUGINLIB_EXPORT_CLASS(test_nodelet::TestNodeletClass, nodelet::Nodelet)

namespace test_nodelet
{
    void TestNodeletClass::onInit()
    {
        NODELET_DEBUG("Initializing nodelet...");
    }
}
