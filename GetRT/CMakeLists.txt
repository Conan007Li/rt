cmake_minimum_required (VERSION 3.8)

project(GetRT)

file(GLOB_RECURSE SRC_LIST ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp )
file(GLOB GetRT_EXPORT_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h)
set(GetRT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include/  PARENT_SCOPE)


add_library(${PROJECT_NAME} SHARED ${SRC_LIST} ${GetRT_EXPORT_HEADERS})

target_compile_definitions(${PROJECT_NAME}
	PUBLIC
)
# GLOG_INCLUDE_DIR: Include directory for glog, not including the
#                   include directory of any dependencies.
# GLOG_LIBRARY: glog library, not including the libraries of any
#               dependencies.

#include_directories(${EIGEN3_INCLUDE_DIR})
target_include_directories(${PROJECT_NAME} PRIVATE
							${EIGEN3_INCLUDE_DIRS}
							${GLOG_INCLUDE_DIR}
							${CERES_INCLUDE_DIRS}
							${OpenMP_CXX_INCLUDE_DIRS}
							${CMAKE_CURRENT_SOURCE_DIR}
							${CMAKE_CURRENT_SOURCE_DIR}/include/
#							${CMAKE_CURRENT_SOURCE_DIR}/../modules/modules/hpc
)
message("EIGEN3_INCLUDE_DIR=${GLOG_LIBRARY}")
message("Eigen3_INCLUDE_DIR=${CERES_LIBRARIES}")
# 定义需要的库
# ${CERES_LIBRARIES}只有一项ceres，后面很多库都没有。。。所以需要自己定义需要链接那些库。
# set(LIBS ${CERES_LIBS_DIR}/libceres.a umfpack cxsparse glog gflags gomp
#         ccolamd btf klu cholmod lapack blas camd amd pthread)

target_link_libraries(
	${PROJECT_NAME} PRIVATE
	${GLOG_LIBRARY}
	${CERES_LIBRARIES}
	OpenMP::OpenMP_CXX
)


install(TARGETS ${PROJECT_NAME} 
		LIBRARY DESTINATION lib
		RUNTIME DESTINATION bin)

#install(FILES 
#        ${CMAKE_SOURCE_DIR}/include/AE_interface.h 
#		 ${CMAKE_SOURCE_DIR}/include/config.h
#		DESTINATION include)

#if(WIN32)
#	file(COPY ${OpenCV_DLL_PATH} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
#endif()
