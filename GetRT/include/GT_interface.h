/**
 * @file GT_interface.h
 * @brief
 * @version 0.1.0
 * @date 2021/12/24
 *
 * @copyright Copyright (c) 2021 SmartMore
 *
 */
#include <ceres/ceres.h>
typedef Eigen::Matrix<double, 3, 3>
    E_Mat33;  // 3*3 double类型的矩阵，用来存储K，R
typedef Eigen::Matrix<double, 3, 1>
    E_Mat31;  // 3*1 double类型的矩阵，存储f0,f1,f2,f3
typedef Eigen::Matrix<double, 2, 1>
    E_Mat21;  // 2*1 double类型的矩阵，用来存储a,b,c,d,
namespace gt {

// ResultCode is for returning status of API call
enum ResultCode {
  kResultOk = 0,
  DataError = -1,
  kResultExecuteFailure = -2,
  InitError = -3,
};

class GTInterface {
 public:
  GTInterface();

  ~GTInterface();

 public:
  ResultCode init();
  ResultCode run();

  /**
   * @brief
   * @param
   * @return
   */
  ResultCode set_cameraK(E_Mat33 cameraK_);
  ResultCode set_length(double l1, double l2);
  ResultCode set_points(E_Mat21 pointA, E_Mat21 pointB, E_Mat21 pointC,
                        E_Mat21 pointD);
  /**
   * @brief
   * @param
   * @return
   */
  void GetR(E_Mat33& R);

  void GetT(E_Mat31& T);

 private:
  class Impl;
  E_Mat31 T;
  E_Mat33 R;

  std::shared_ptr<Impl> impl_;
};

}  // namespace gt