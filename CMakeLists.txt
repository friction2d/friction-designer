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

cmake_minimum_required(VERSION 3.12)
project(friction-designer)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/src/cmake")
include(friction-designer-version)
include(friction-designer-meta)

if (CUSTOM_BUILD STREQUAL "")
    write_file(version.txt ${PROJECT_VERSION})
else()
    write_file(version.txt ${PROJECT_VERSION}-${CUSTOM_BUILD})
endif()

add_subdirectory(src/engine)
#add_subdirectory(src/core)
#add_subdirectory(src/ui)
#add_subdirectory(src/app)
#add_dependencies(frictioncore Engine)
