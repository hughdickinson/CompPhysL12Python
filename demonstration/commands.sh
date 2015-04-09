#!/bin/bash

# DEFINE SOME LOCAL SHELL VARIABLES
PYTHONEXE=python2.7

SC_SOURCE_BASEDIR=cppSourceFiles
SC_INCLUDE_DIR=${SC_SOURCE_BASEDIR}/include
SC_SOURCE_DIR=${SC_SOURCE_BASEDIR}/src
SC_LIB_DIR=${SC_SOURCE_BASEDIR}/lib

if [ "$1" = "trivial" ]; then

    ${PYTHONEXE} TrivialSetup.py build_ext --inplace

elif [ "$1" = "simple" ]; then

    ${PYTHONEXE} SimpleSetup.py build_ext --inplace

elif [ "$1" = "typed" ]; then

    ${PYTHONEXE} TypedSetup.py build_ext --inplace

elif [ "$1" = "buildcpp" ]; then

    BUILD_COMMAND="clang++ -std=c++11 -fPIC -shared -o ${SC_LIB_DIR}/libStatsCalculatorCAPI.so -I${SC_INCLUDE_DIR} ${SC_SOURCE_DIR}/StatsCalculator.cpp ${SC_SOURCE_DIR}/StatsCalculatorCAPI.cpp"
    
    echo "BUILDING C++ LIBRARY USING:\n${BUILD_COMMAND}"
    echo "${BUILD_COMMAND}" | sh
    echo "\nLIBRARY SYMBOLS (MANGLED):\n"
    nm ${SC_LIB_DIR}/libStatsCalculatorCAPI.so
    
elif [ "$1" = "statscalc" ]; then

    CFLAGS=-I${SC_INCLUDE_DIR} LDFLAGS=-L${SC_LIB_DIR} ${PYTHONEXE} StatsCalcSetup.py build_ext --inplace

elif [ "$1" = "setupdirs" ]; then

    mkdir -p ${SC_LIB_DIR}

else

    echo "Unrecognized argument."

fi
