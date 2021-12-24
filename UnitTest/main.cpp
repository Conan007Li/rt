#include "GT_interface.h"
extern gt::ResultCode TestFramework_GT();
int main() {
  gt::ResultCode flag = TestFramework_GT();
  return 0;
}