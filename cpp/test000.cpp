#include <iostream>
using namespace std; // std namespace is used

int main(int argc, char *argv[]) {
  int month = 11, day = 3;
  double percent = 25.2525;

  cout << "argc:" << argc << "\n";
  for (int i=0; i < 2; i++) {
    cout << "argv[" << i << "]:" << argv[i] << "\n";
  }

  cout << month << "月";
  cout << day << "日\n";
  cout << "降水確率" << percent << "%\n";

  return 0;
}
