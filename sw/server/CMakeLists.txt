cmake_minimum_required(VERSION 2.8.3)

SET(CMAKE_SYSTEM_NAME Linux)

project(server)

add_definitions(--std=c++14 -pthread -Wall)

set(BIN ${PROJECT_BINARY_DIR}/bin)

include_directories(/usr/local/include)

set(TARGET_FILES main.cpp processing.cpp)

ADD_CUSTOM_TARGET(debug_x64
  				  COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Debug ${CMAKE_SOURCE_DIR}
  				  COMMAND make all
  				  COMMENT "Switch CMAKE_BUILD_TYPE to Debug")

ADD_CUSTOM_TARGET(release_arm
  				  COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Release ${CMAKE_SOURCE_DIR}
  				  COMMAND make all 
  				  COMMENT "Switch CMAKE_BUILD_TYPE to Release")

if (CMAKE_BUILD_TYPE MATCHES Release)
	# specify arm gcc here
	# use the same gcc to build fastcgipp lib
    set(triple /usr/bin/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-)
    set(TARGET_FILES main.cpp)
	set(CMAKE_C_LINK_EXECUTABLE ${triple}ld)
	set(CMAKE_CXX_COMPILER ${triple}g++)
	set(CMAKE_CC_COMPILER ${triple}gcc)
	link_directories(lib)
endif()

if (CMAKE_BUILD_TYPE MATCHES Debug)
	set(TARGET_FILES main.cpp processing.cpp)
	link_directories(lib)
endif()

set(TARGET_LIBS fastcgipp pthread fftw3)
add_executable(${PROJECT_NAME} ${TARGET_FILES})
target_link_libraries(${PROJECT_NAME} ${TARGET_LIBS})

install(TARGETS ${PROJECT_NAME} DESTINATION ${BIN})

message(${BIN})
