if(USING_CLANG_TIDY)
    # if USING_CLANG_TIDY is ON, then the clang-tidy works, which could be downloaded by downloadTools.sh
    message("-- USING_CLANG_TIDY: ON")
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    set(CMAKE_CXX_CLANG_TIDY "${CMAKE_CURRENT_SOURCE_DIR}/tools/clang-tools/bin/clang-tidy")
endif()
