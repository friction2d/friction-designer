#
# Friction - https://friction.graphics
#
# Copyright (c) Ole-André Rodlie and contributors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#

#set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#set(QUAZIP_LIBRARIES_DIRS "/usr/lib" CACHE STRING "quazip library path")
#set(QUAZIP_LIBRARIES "quazip5" CACHE STRING "quazip library")
#set(QUAZIP_INCLUDE_DIRS "/usr/include/quazip5" CACHE STRING "quazip includes path")

if(NOT APPLE)
    if(UNIX AND NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        message(FATAL_ERROR "Only Clang is supported.")
    elseif(WIN32 AND NOT CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        message(FATAL_ERROR "Only MSVC is supported.")
    endif()
endif()

if(UNIX)
    add_compile_options(-Wall -Wextra -Wno-unused-private-field)
    if(NOT ${LINUX_DEPLOY})
        add_compile_options(-Wno-deprecated-copy-with-user-provided-copy)
    endif()
    if(APPLE)
        add_compile_options(-frtti)
    endif()
endif()

if(CMAKE_BUILD_TYPE MATCHES "^(release|Release|RELEASE)$")
    add_definitions(-DQT_NO_DEBUG_OUTPUT)
else()
    add_definitions(-DQT_MESSAGELOGCONTEXT)
endif()

if(MSVC)
    add_definitions("/MP")
endif()

find_package(PkgConfig QUIET)
find_package(QT NAMES Qt5 COMPONENTS Core REQUIRED)
find_package(
    Qt${QT_VERSION_MAJOR}
    5.15.3
    COMPONENTS
    Gui
    Widgets
    OpenGL
    Qml
    Xml
    REQUIRED
)
set(QT_LIBRARIES
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::OpenGL
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Xml
)

if(WIN32)
    set(SKIA_LIBRARIES
        skia
        user32
        opengl32)
    add_definitions(-DSKIA_DLL)
    set(SKIA_LIBRARIES_DIRS ${CMAKE_SOURCE_DIR}/sdk/bin)
else()
    if(APPLE)
        set(SKIA_LIBRARIES skia)
    else()
        set(SKIA_LIBRARIES skia.friction)
    endif()
    set(SKIA_LIBRARIES_DIRS ${CMAKE_CURRENT_BINARY_DIR}/../engine/skia)
endif()
