''' 
Cython refers to files with a ".pxd" suffix as "definition files". They behave somewhat like 
"header files" for Cython.

The code in this file is used to provide Cython with the C function declarations that are 
contained within "cppSourceFiles/include/StatsCalculator.h" i.e. those that comprise the
C API for StatsCalculator.

The file contains a single code block with a specially formatted opening clause that defines 
the file that contains the function declarations.

In this simple case, the code block contains verbatim copy of the functions that comprise
the C API for StatsCalculator, with the semicolon characters removed. 

Note that the "cdef" keyword is used to specify that these functions have should are defined in
a C language context. They cannot be called from the Python interpreter.

The "extern" keyword specifies that the functionality associated with each function is
provided by a shared library.
'''
cdef extern from "cppSourceFiles/include/StatsCalculator.h" :
    int statsCalcCreate()
    void statsCalcDestroy(int handle)
    void statsCalcAppendValue(int handle, double value)
    void statsCalcReadFile(int handle, const char * fileName)
    void statsCalcWriteStats(int handle, const char * fileName)
    double statsCalcGetSum(int handle)
    double statsCalcGetMean(int handle)
    double statsCalcGetStdDev(int handle)
    