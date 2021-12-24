#include "GT_interface.h"
#include "GT_algo.h"
#ifndef WIN32
#define DEFAULT_VISIBILITY __attribute__((visibility("default")))
#else
#define DEFAULT_VISIBILITY
#endif

namespace gt {

class GTInterface::Impl {
 public:
  Impl() {};

  ~Impl() = default;

 public:
  ResultCode init();
  ResultCode run();
  ResultCode set_points(E_Mat21 pointA, E_Mat21 pointB, E_Mat21 pointC,
                        E_Mat21 pointD);
  ResultCode set_cameraK(E_Mat33 cameraK_);
  ResultCode set_length(double l1, double l2);
  void GetR(E_Mat33& R);

  void GetT(E_Mat31& T);

 private:
  GT_Algo GT_algo;
  E_Mat31 T;
  E_Mat33 R;
};

/*********************************************************************************
**************************************** Interface
******************************
*********************************************************************************/

DEFAULT_VISIBILITY GTInterface::GTInterface()
    : impl_((std::make_shared<GTInterface::Impl>())) {
  if (GTInterface::impl_->init() != kResultOk) {
    std::cout << "initialization error" << std::endl;
  }
}
DEFAULT_VISIBILITY GTInterface::~GTInterface() {
}
DEFAULT_VISIBILITY ResultCode GTInterface::run() {
  GTInterface::impl_->run();
  return ResultCode::kResultOk;
}

DEFAULT_VISIBILITY void GTInterface::GetR(E_Mat33& R) {
  GTInterface::impl_->GetR(R);
}

DEFAULT_VISIBILITY void GTInterface::GetT(E_Mat31& T) {
  GTInterface::impl_->GetT(T);
}
DEFAULT_VISIBILITY ResultCode GTInterface::set_points(E_Mat21 pointA,
                                                      E_Mat21 pointB,
                                                      E_Mat21 pointC,
                                                      E_Mat21 pointD) {
  GTInterface::impl_->set_points(pointA, pointB, pointC, pointD);
  return ResultCode::kResultOk;
}

DEFAULT_VISIBILITY ResultCode GTInterface::set_cameraK(E_Mat33 cameraK_) {
  GTInterface::impl_->set_cameraK(cameraK_);
  return ResultCode::kResultOk;
}
DEFAULT_VISIBILITY ResultCode GTInterface::set_length(double l1, double l2) {
  GTInterface::impl_->set_length(l1,l2);
  return ResultCode::kResultOk;
}
/*********************************************************************************
 **************************************** Impl
 ************************************
 *********************************************************************************/

ResultCode GTInterface::Impl::init() { 
  GT_algo = GT_Algo();
  return kResultOk;
}


ResultCode GTInterface::Impl::set_points(E_Mat21 pointA, E_Mat21 pointB,
                                         E_Mat21 pointC, E_Mat21 pointD) {
  GT_algo.set_points(pointA, pointB, pointC, pointD);
  return kResultOk;
}
ResultCode GTInterface::Impl::set_cameraK(E_Mat33 cameraK_) {
  GT_algo.set_cameraK(cameraK_);
  return kResultOk;
}
ResultCode GTInterface::Impl::set_length(double l1, double l2) {
  GT_algo.set_length(l1,l2);
  return kResultOk;
}
ResultCode GTInterface::Impl::run() {
  GT_algo.calculate();
  return kResultOk;
}
void GTInterface::Impl::GetT(E_Mat31& T) { 
  T = GT_algo.get_T();
}
void GTInterface::Impl::GetR(E_Mat33& R) {
    R = GT_algo.get_R(); 
}
}  // namespace gt
