if(APPLE)
    set(OPENMP_LOCAL_PATH ${CMAKE_SOURCE_DIR}/3rdparty/OpenMP_iOS)
else()
    set(OPENMP_LOCAL_PATH "")
endif()

if(EXISTS ${OPENMP_LOCAL_PATH})
    set(OpenMP_DIR ${OPENMP_LOCAL_PATH})
else()
    if(APPLE)
        set(OpenMP_URL "http://artifactory.smoa.cloud/artifactory/Daotong-Panorama-Dev/3rdparty/openmp-5.0.0-ios11-universal.zip")
        set(OpenMP_MD5 "50dd5f7c80463ddab9fdc93cc8732eb7")
    else()
        set(OpenMP_URL "")
        set(OpenMP_MD5 "")
    endif()

    if(NOT OpenMP_URL)
        message(FATAL_ERROR "Could Not Found OpenMP_URL!")
    endif()

    include(FetchContent)

    FetchContent_Declare(OpenMP
        URL ${OpenMP_URL}
        SOURCE_DIR ${OPENMP_LOCAL_PATH}
        URL_MD5 ${OpenMP_MD5}
    )

    message(STATUS "Fetch OpenMP from ${OpenMP_URL}.")
    FetchContent_MakeAvailable(OpenMP)
    message(STATUS "Fetch OpenMP finished.")

    # get OpenMP
    FetchContent_GetProperties(OpenMP SOURCE_DIR OpenMP_DIR)
endif()

if(APPLE)
    list(APPEND CMAKE_LIBRARY_PATH ${OpenMP_DIR}/lib)
    list(APPEND CMAKE_INCLUDE_PATH ${OpenMP_DIR}/include)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
    set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
    set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE)
endif()
