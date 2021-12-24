cmake_minimum_required (VERSION 3.8)

project ("GetRt")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(BUILD_FOR_IOS_SIM FALSE) 
if(WIN32)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
    set(BUILD_SHARED_LIBS TRUE)
endif()

include(check/AddressSanitize)
if(UNIX AND NOT APPLE AND NOT ANDROID)
    include(check/ClangTidy)
endif()

include(fetch/Eigen3)
include(fetch/Glog)
include(fetch/Ceres)

find_package(Eigen3 REQUIRED)
find_package(Ceres REQUIRED)
find_package(OpenMP REQUIRED)

add_subdirectory(GetRT)
add_subdirectory(UnitTest)

