#include <nodelet/nodelet.h>

namespace test_nodelet
{

    class TestNodeletClass : public nodelet::Nodelet
    {
        public:
            virtual void onInit();
    };

}
