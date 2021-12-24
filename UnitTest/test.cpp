#include "GT_interface.h"
gt::ResultCode TestFramework_GT() {
  E_Mat33 cameraK, R;
  E_Mat21 point0, point1, point2, point3;
  E_Mat31 T;
  double length1 = 800.0, length2 = 800.0;
  cameraK << 3.328582588559217e+03, 0, 1.521568136668334e+03, 0,
      3.315295910597914e+03, 2.013087950236134e+03, 0, 0, 1;
  /*cameraK << 1, 2, 3, 4, 5, 6, 7, 8, 9;*/
  point0 << 952, 1975;
  point1 << 1609, 2137;
  point2 << 1987, 1847;
  point3 << 1597, 1267;

  gt::GTInterface getrt;
  getrt.set_length(length1, length2);
  getrt.set_cameraK(cameraK);
  getrt.set_points(point0, point1, point2, point3);

  getrt.run();
  getrt.GetR(R);
  getrt.GetT(T);

  std::cout << "T : " << std::endl << T << std::endl;
  std::cout << "R : " << std::endl << R << std::endl;

  E_Mat31 P1;
  P1 << 0, 800, 0;
  E_Mat31 P2;
  P2 << 800, 0, 0;
  E_Mat31 P3;
  P3 << 0, 0, 800;

  std::cout << "Reprojection : " << std::endl;
  E_Mat31 uv1 = cameraK * (R * P1 + T);
  std::cout << "point 0 : " << uv1(0) / uv1(2) << " " << uv1(1) / uv1(2)
            << std::endl;
  E_Mat31 uv2 = cameraK * (R * P2 + T);
  std::cout << "point 2 : " << uv2(0) / uv2(2) << " " << uv2(1) / uv2(2)
            << std::endl;
  E_Mat31 uv3 = cameraK * (R * P3 + T);
  std::cout << "point 3 : " << uv3(0) / uv3(2) << " " << uv3(1) / uv3(2)
            << std::endl;

  return gt::kResultOk;
}