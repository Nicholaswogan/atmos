cmake_minimum_required(VERSION "3.12")

project(atmos Fortran)

option(BUILD_CLIMA "Set to ON to build Clima" OFF)

option(BUILD_PHOTOCHEM "Set to ON to build Photochem" ON)

if (NOT CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()

if ("${CMAKE_Fortran_COMPILER_ID}" MATCHES "GNU" 
   AND CMAKE_BUILD_TYPE STREQUAL "Debug")
   set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -Wunused")
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fno-automatic -fdefault-integer-8 -fdefault-real-8")

set(PHOTOCHEM_SUBS ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Photgrid.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Rates.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/RatesHJs.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Rainout.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Aqueous.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Photo.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Initphoto.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Densty.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Difco.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Sedmnt.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/PhotSatrat.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Aertab.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Output.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Aercon.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Dochem.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Chempl.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Ltning.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Xsections.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/newXS.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Youngsun.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Initmie.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Lnum.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/ireset.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Twostr.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Rayleigh.f
                   ${CMAKE_SOURCE_DIR}/PHOTOCHEM/SUBROUTINES/Spline.f)

set(LINPACK_SOURCES ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/saxpy.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sgbfa.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sgefa.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sgbsl.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sgesl.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sscal.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/isamax.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sgbco.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sgtsl.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sdot.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/sasum.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/daxpy.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/dgbfa.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/dgbco.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/dgbsl.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/dscal.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/dasum.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/ddot.f
                    ${CMAKE_SOURCE_DIR}/PHOTOCHEM/LINPACK/idamax.f)

if(NOT EXISTS ${CMAKE_SOURCE_DIR}/PHOTOCHEM/INPUTFILES/parameters.inc)
  message (FATAL_ERROR "Need to select a template.")
endif()

foreach (SUB PHOTOCHEM_SUBS)
  set_source_files_properties(SUB PROPERTIES OBJECT_DEPENDS 
                              ${CMAKE_SOURCE_DIR}/PHOTOCHEM/INPUTFILES/parameters.inc) 
endforeach()

if (BUILD_PHOTOCHEM)
  
  add_library(photochem_subs ${PHOTOCHEM_SUBS})
  target_include_directories(photochem_subs PUBLIC ${CMAKE_SOURCE_DIR})

  add_library(linpack ${LINPACK_SOURCES})

  add_executable(Photo.run ${CMAKE_SOURCE_DIR}/PhotoMain.f)
  target_include_directories(Photo.run PUBLIC ${CMAKE_SOURCE_DIR})
  target_link_libraries(Photo.run photochem_subs linpack)
  
  install(TARGETS Photo.run DESTINATION ${CMAKE_SOURCE_DIR})
  
endif()

if (BUILD_CLIMA)
  # commands here
endif()

if (NOT BUILD_PHOTOCHEM AND NOT BUILD_CLIMA)
  message (FATAL_ERROR "Not building either photochem or clima. Must build something!")
endif()

