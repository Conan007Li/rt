set(EIGEN3_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/Eigen3_${CMAKE_SYSTEM_NAME})
set(EIGEN3_LOCAL_CMAKE_PATH ${EIGEN3_LOCAL_PATH}/share/eigen3/cmake)

#message("EIGEN3_INCLUDE_DIR=${EIGNE3_INCLUDE_DIR}")

if(EXISTS ${EIGEN3_LOCAL_CMAKE_PATH})
    message(STATUS "Eigen3_DIR exists at ${EIGEN3_LOCAL_CMAKE_PATH}, fetch skipped.")
    set(Eigen3_DIR ${EIGEN3_LOCAL_CMAKE_PATH})
else()
    if(ANDROID)
        set(Eigen3_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/eigen-3.4.0-android.zip")
        set(Eigen3_MD5 "b957f80046c30a761da5f0a53af498e2")
    elseif(APPLE)
        set(Eigen3_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/eigen3-3.3.90-ios.zip")
        set(Eigen3_MD5 "9d482e8c71201bf65154a23e4c367a56")
    elseif(UNIX)
        set(Eigen3_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/eigen-3.4.0-linux_x86.zip")
        set(Eigen3_MD5 "f6da1cd30ce411524c12068708c1aefa")
    elseif(WIN32)
        set(Eigen3_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/windows_x64_vs2019/eigen-3.4.0.zip")
        set(Eigen3_MD5 "0f6c9e9193af03f7a66f1f52a9879794")   
    endif()

    if(NOT Eigen3_URL)
        message(FATAL_ERROR "Could Not Found Eigen3_URL!")
    endif()

    include(FetchContent)

    FetchContent_Declare(Eigen3
        URL ${Eigen3_URL}
        SOURCE_DIR ${EIGEN3_LOCAL_PATH}
        URL_MD5 ${Eigen3_MD5}
    )

    message(STATUS "Fetch Eigen3 from ${Eigen3_URL}.")
    # get Eigen3
    FetchContent_MakeAvailable(Eigen3)
    message(STATUS "Fetch Eigen3 finished.")
        
    set(Eigen3_DIR ${EIGEN3_LOCAL_CMAKE_PATH})
    message(STATUS "Eigen3_DIR: ${Eigen3_DIR}.")
endif()
