cmake_minimum_required(VERSION 3.0)
project(chips-env CXX)

# Build Configuration
set(CMAKE_CXX_STANDARD 11)

#set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib)
#set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)

# This is just to have neat colors in Ninja
option(FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." OFF)
if(${FORCE_COLORED_OUTPUT})
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
       add_compile_options(-fdiagnostics-color=always)
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
       add_compile_options(-fcolor-diagnostics)
    endif()
endif()

# Add the submodule directory
add_subdirectory(chips)

if(EXISTS $ENV{CHIPSENV}/data/genie/xsecs_G0000b00000.xml)
  message(STATUS "Already have xsecs_G0000b00000.xml")
else()
  message(STATUS "Downloading xsecs_G0000b00000.xml")
  file(DOWNLOAD http://www.hep.ucl.ac.uk/~jtingey/genie/xsecs_G0000b00000.xml $ENV{CHIPSENV}/genie/data/xsecs_G0000b00000.xml)
endif()

if(EXISTS $ENV{CHIPSENV}/data/genie/xsecs_G1802a00000.xml)
  message(STATUS "Already have xsecs_G1802a00000.xml")
else()
  message(STATUS "Downloading xsecs_G1802a00000.xml")
  file(DOWNLOAD http://www.hep.ucl.ac.uk/~jtingey/genie/xsecs_G1802a00000.xml $ENV{CHIPSENV}/genie/data/xsecs_G1802a00000.xml)
endif()
