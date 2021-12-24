if(${BUILD_FOR_IOS_SIM} AND APPLE)
    set(CERES_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/Ceres_iOS_sim)
else()
    set(CERES_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/Ceres_${CMAKE_SYSTEM_NAME})
endif()

if(ANDROID)
    set(CERES_LOCAL_CMAKE_PATH ${CERES_LOCAL_PATH}/${CMAKE_ANDROID_ARCH_ABI}/lib/cmake/Ceres)
elseif(WIN32)
    set(CERES_LOCAL_CMAKE_PATH ${CERES_LOCAL_PATH}/CMake)
    set(CERES_INCLUDE_DIRS ${CERES_LOCAL_PATH}/include)
else()
    set(CERES_LOCAL_CMAKE_PATH ${CERES_LOCAL_PATH}/lib/cmake/Ceres)
endif()
if(EXISTS ${CERES_LOCAL_CMAKE_PATH})
    message(STATUS "Ceres_DIR exists at ${CERES_LOCAL_CMAKE_PATH}, fetch skipped.")
    set(Ceres_DIR ${CERES_LOCAL_CMAKE_PATH})
else()
    if(${BUILD_FOR_IOS_SIM} AND APPLE)
        set(Ceres_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/ceres-2.0.0-ios11-simulator-x86_64.zip")
        set(Ceres_MD5 "4ff2d7c7cdd05954369df7c3b72e033c")
    elseif(ANDROID)
        set(Ceres_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/ceres-2.0.0-android.zip")
        set(Ceres_MD5 "a7aae51caf14019b5758a20173f3542a")
    elseif(APPLE)
        set(Ceres_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/ceres-2.0.0-ios11-arm64.zip")
        set(Ceres_MD5 "ae988b7481dc8f69d6259268b9aab913")
    elseif(UNIX)
        set(Ceres_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/ceres-2.0.0-linux_x86.zip")
        set(Ceres_MD5 "0527347372ec113d61a5d274ac4d25b0")
    elseif(WIN32)
        set(Ceres_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/windows_x64_vs2019/ceres-2.0.0.zip")
        set(Ceres_MD5 "db5b6db7355660ca8c381434e0fc6ea8")
    endif()

    if(NOT Ceres_URL)
        message(FATAL_ERROR "Could Not Found Ceres_URL!")
    endif()

    include(FetchContent)

    FetchContent_Declare(Ceres
        URL ${Ceres_URL}
        SOURCE_DIR ${CERES_LOCAL_PATH}
        URL_MD5 ${Ceres_MD5}
    )

    message(STATUS "Fetch Ceres from ${Ceres_URL}.")
    # get Ceres
    FetchContent_MakeAvailable(Ceres)
    message(STATUS "Fetch Ceres finished.")

    set(Ceres_DIR ${CERES_LOCAL_CMAKE_PATH})
    message(STATUS "Ceres_DIR: ${Ceres_DIR}.")
endif()
