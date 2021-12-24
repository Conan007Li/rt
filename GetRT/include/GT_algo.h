#include <ceres/ceres.h>

#include <iostream>
typedef Eigen::Matrix<double, 3, 3>
    E_Mat33;  // 3*3 double类型的矩阵，用来存储K，R
typedef Eigen::Matrix<double, 3, 1>
    E_Mat31;  // 3*1 double类型的矩阵，存储f0,f1,f2,f3
typedef Eigen::Matrix<double, 2, 1>
    E_Mat21;  // 2*1 double类型的矩阵，用来存储a,b,c,d,
class GT_Algo {
 private:
  E_Mat31 point0, point1, point2, point3, transform;
  E_Mat33 cameraK, rotation;
  double length1, length2;

 public:

   GT_Algo() = default;

   ~GT_Algo() = default;
  //传入四个点
  void set_points(E_Mat21 pointA, E_Mat21 pointB, E_Mat21 pointC,
                  E_Mat21 pointD) {
    point0 << pointA, 1;
    point1 << pointB, 1;
    point2 << pointC, 1;
    point3 << pointD, 1;
  }
  //传入内参K
  void set_cameraK(E_Mat33 cameraK_) { cameraK = cameraK_; }
  //传入两个边长度
  void set_length(double l1, double l2) {
    length1 = l1;
    length2 = l2;
  }
  E_Mat33 get_R() { return rotation; }
  E_Mat31 get_T() { return transform; }
  void calculate();
};
