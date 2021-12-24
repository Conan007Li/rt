set(GLOG_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/Glog_${CMAKE_SYSTEM_NAME})
set(GLOG_LOCAL_CMAKE_PATH ${GLOG_LOCAL_PATH}/lib/cmake/glog)
if(EXISTS ${GLOG_LOCAL_CMAKE_PATH})
    message(STATUS "Glog_DIR exists at ${GLOG_LOCAL_CMAKE_PATH}, fetch skipped.")
    set(glog_DIR ${GLOG_LOCAL_CMAKE_PATH})
    if (WIN32)
        set (glog_DLL_PATH ${glog_DIR}/../../../bin/glog.dll)
    endif()
else()
    if(UNIX AND NOT APPLE AND NOT ANDROID)
        set(Glog_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/glog-0.5.0-linux_x86_gcc7.zip")
        set(Glog_MD5 "f6c34188da3f0a645557380ba4110c6a")
    elseif(WIN32)
        set(Glog_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/windows_x64_vs2019/glog-0.5.0.zip")
        set(Glog_MD5 "fc697dac7b52ab9f4d0599cd4231afe8")
    endif()

    if(NOT Glog_URL)
        message(FATAL_ERROR "Could Not Found Glog_URL!")
    endif()

    include(FetchContent)

    FetchContent_Declare(Glog
        URL ${Glog_URL}
        SOURCE_DIR ${GLOG_LOCAL_PATH}
        URL_MD5 ${Glog_MD5}
    )

    message(STATUS "Fetch Glog from ${Glog_URL}.")
    # get Glog
    FetchContent_MakeAvailable(Glog)
    message(STATUS "Fetch Glog finished.")

    set(glog_DIR ${GLOG_LOCAL_CMAKE_PATH})
    if (WIN32)
        set (glog_DLL_PATH ${glog_DIR}/../../../bin/glog.dll)
    endif()
    message(STATUS "glog_DIR: ${glog_DIR}.")
endif()
