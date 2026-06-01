cmake_minimum_required(VERSION 3.20)
project(wasd_tweak_launcher LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(MSVC AND POLICY CMP0091)
  cmake_policy(SET CMP0091 NEW)
endif()
if(MSVC)
  set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

add_executable(wasd_tweak_launcher WIN32 main.cpp)
set_target_properties(wasd_tweak_launcher PROPERTIES OUTPUT_NAME "wasd+performance_runtime_tweaker_x64")

target_link_libraries(wasd_tweak_launcher PRIVATE user32 gdi32 dwmapi shlwapi shell32)

if(MSVC)
  target_compile_options(wasd_tweak_launcher PRIVATE /W4 /utf-8)
  target_link_options(wasd_tweak_launcher PRIVATE
    "/MANIFESTUAC:level='requireAdministrator' uiAccess='false'")
endif()
