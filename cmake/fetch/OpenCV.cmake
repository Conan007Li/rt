if(APPLE)
    set(OPENCV_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/OpenCV_${CMAKE_SYSTEM_NAME}/opencv2.framework)
else()
    set(OPENCV_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/OpenCV_${CMAKE_SYSTEM_NAME})
endif()

if(APPLE)
    get_filename_component(OPENCV_LOCAL_CMAKE_PATH ${OPENCV_LOCAL_PATH} DIRECTORY)
elseif(ANDROID)
    set(OPENCV_LOCAL_CMAKE_PATH ${OPENCV_LOCAL_PATH}/sdk/native/jni)
elseif(UNIX)
    set(OPENCV_LOCAL_CMAKE_PATH ${OPENCV_LOCAL_PATH}/lib/cmake/opencv4)
elseif(WIN32)
    set(OPENCV_LOCAL_CMAKE_PATH ${OPENCV_LOCAL_PATH})
endif()

if(EXISTS ${OPENCV_LOCAL_CMAKE_PATH})
    message(STATUS "OpenCV_DIR exists at ${OPENCV_LOCAL_CMAKE_PATH}, fetch skipped.")
    set(OpenCV_DIR ${OPENCV_LOCAL_CMAKE_PATH})
    if(WIN32)
        file(GLOB OpenCV_DLL_PATH "${OpenCV_DIR}/x64/vc16/bin/*.dll")
    endif()
else()
    if(ANDROID)
        set(OpenCV_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/opencv-4.5.3-android.zip")
        set(OpenCV_MD5 "3a9d5eb4e55a1ddbf70c281ebc3bf868")
    elseif(APPLE)
        set(OpenCV_URL "http://artifactory.smoa.cloud/artifactory/opencv/opencv-4.5.3-ios-framework.zip")
        set(OpenCV_MD5 "187c3b9cef30e99bc432184277a1bed6")
    elseif(UNIX)
        set(OpenCV_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/opencv-4.5.3-linux-x86_gcc7.zip")
        set(OpenCV_MD5 "2bc24a5708f9ea412f57f01761452106")
    elseif(WIN32)
        set(OpenCV_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/windows_x64_vs2019/opencv-4.5.3.zip")
        set(OpenCV_MD5 "69d8fe363a136990134a006c980bef42")
    endif()

    if(NOT OpenCV_URL)
        message(FATAL_ERROR "Could Not Found OpenCV_URL!")
    endif()

    include(FetchContent)

    FetchContent_Declare(OpenCV
        URL ${OpenCV_URL}
        SOURCE_DIR ${OPENCV_LOCAL_PATH}
        URL_MD5 ${OpenCV_MD5}
    )

    message(STATUS "Fetch OpenCV from ${OpenCV_URL}.")
    # get OpenCV
    FetchContent_MakeAvailable(OpenCV)
    message(STATUS "Fetch OpenCV finished.")

    set(OpenCV_DIR ${OPENCV_LOCAL_CMAKE_PATH})
    if(WIN32)
        file(GLOB OpenCV_DLL_PATH "${OpenCV_DIR}/x64/vc16/bin/*.dll")
    endif()
    message(STATUS "OpenCV_DIR: ${OpenCV_DIR}.")
endif()
