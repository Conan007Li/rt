#include <iostream>

#include "GT_algo.h"
struct Rule {
 public:
  Rule(const E_Mat31& f0, const E_Mat31& f1, const E_Mat31& f2,
       const E_Mat31& f3, const double& length1, const double& length2)
      : f0_(f0),
        f1_(f1),
        f2_(f2),
        f3_(f3),
        length1_(length1),
        length2_(length2) {}
  template <typename T>
  bool operator()(const T* const k0, const T* const k1, const T* const k2,
                  const T* const k3, T* residual) const {
    typedef Eigen::Matrix<T, 3, 1> E_Mat31_T;
    E_Mat31_T T_f0(T(f0_(0)), T(f0_(1)), T(f0_(2)));
    E_Mat31_T T_f1(T(f1_(0)), T(f1_(1)), T(f1_(2)));
    E_Mat31_T T_f2(T(f2_(0)), T(f2_(1)), T(f2_(2)));
    E_Mat31_T T_f3(T(f3_(0)), T(f3_(1)), T(f3_(2)));


    E_Mat31_T ans1 = k1[0] * T_f1 - k0[0] * T_f0;
    E_Mat31_T ans2 = k2[0] * T_f2 - k0[0] * T_f0;
    E_Mat31_T ans3 = k3[0] * T_f3 - k0[0] * T_f0;
    // dot(k1*f1-k0*f0,k3*f3-k0*f0)
    residual[0] = ans1[0] * ans3[0] + ans1[1] * ans3[1] + ans1[2] * ans3[2];
    // dot(k1 * f1 - k0 * f0, k2 * f2 - k0 * f0) == 0
    residual[1] = ans1[0] * ans2[0] + ans1[1] * ans2[1] + ans1[2] * ans2[2];
    // dot(k3*f3-k0*f0,k2*f2-k0*f0)==0
    residual[2] = ans2[0] * ans3[0] + ans2[1] * ans3[1] + ans2[2] * ans3[2];
    // norm(k1 * f1 - k0 * f0) + norm(k2 * f2 - k0 * f0) == 1600
    residual[3] = ans1.norm() - T(length1_);
    residual[4] = ans2.norm() - T(length2_);
    return true;
  }
  const E_Mat31 f0_;
  const E_Mat31 f1_;
  const E_Mat31 f2_;
  const E_Mat31 f3_;
  const double length1_;
  const double length2_;
};
void GT_Algo::calculate() {
  // std::cout << "start" << std::endl;
  E_Mat31 f0, f1, f2, f3;
  f0 = cameraK.inverse() * point1;
  f1 = cameraK.inverse() * point0;
  f2 = cameraK.inverse() * point2;
  f3 = cameraK.inverse() * point3;

  double k0 = 20000, k1 = 20000, k2 = 20000, k3 = 20000;
  ceres::Problem problem;
  problem.AddResidualBlock(new ceres::AutoDiffCostFunction<Rule, 5, 1, 1, 1, 1>(
                               new Rule(f0, f1, f2, f3, length1, length2)),
                           NULL, &k0, &k1, &k2, &k3);

  // std::cout << "k0 : " << k0 << ", k1 : " << k1 << " , k2 : " << k2 << ", k3
  // :" << k3 << std::endl;

  //第三部分： 配置并运行求解器
  ceres::Solver::Options options;
  options.linear_solver_type = ceres::DENSE_QR;
  options.minimizer_progress_to_stdout = false;  //输出到cout
  options.gradient_tolerance = 1e-16;
  options.function_tolerance = 1e-16;
  // options.max_solver_time_in_seconds = 10;
  // options.max_num_iterations = 500;
  ceres::Solver::Summary summary;      //优化信息
  Solve(options, &problem, &summary);  //求解!!!

  // std::cout << "k0 : " << k0 << ", k1 : " << k1 << " , k2 : " << k2 << ", k3
  // :" << k3 << std::endl;

  E_Mat31 A = k1 * f1 - k0 * f0;
  E_Mat31 B = k0 * f0;
  E_Mat31 C = k2 * f2 - k0 * f0;
  E_Mat31 D = k3 * f3 - k0 * f0;
  transform = B;

  A = A / A.norm();
  C = C / C.norm();
  D = D / D.norm();

  rotation << C(0), A(0), D(0), C(1), A(1), D(1), C(2), A(2), D(2);
}