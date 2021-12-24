cmake_minimum_required (VERSION 3.8)

project(UnitTestDemo)

file(GLOB TEST_SRC_LIST *.c* *.h)

add_executable(
	${PROJECT_NAME} ${TEST_SRC_LIST}
)


target_include_directories(${PROJECT_NAME} PRIVATE
	                    ${EIGEN3_INCLUDE_DIRS}
						${GLOG_INCLUDE_DIR}
						${GetRT_INCLUDE_DIRS}
						${CERES_INCLUDE_DIRS}
						${CMAKE_CURRENT_SOURCE_DIR}
						${CMAKE_CURRENT_SOURCE_DIR}/../GetRT/include)

target_link_libraries(
	${PROJECT_NAME} PRIVATE
	${GLOG_LIBRARY}
	GetRT
	${CERES_LIBRARIES}
)

# if ( EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/data )
# 	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/data DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
# endif()

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)


#file(COPY ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

