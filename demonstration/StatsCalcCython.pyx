''' 
Cython refers to files with a ".pyx" suffix as "implemenation files files". They are used to 
define a mapping between the functions that are defined in the corresponding ".pxd" file
and functions, classes and methods that can be instantiated or invoked by the Python interpreter.

The "cimport" keyword is used like the "import" keyword in Python to bring the definitions that
those files contain into the local namespace. The ".pdx" is implicitly appended.

In this case, the import statement is actually superflous because it has the same file prefix
as the current file. When building a ".pyx" file, the Cython build system will automatically 
"cimport" a ".pdx" file with the same prefix. Nonetheless, including this statement is not an 
error.
'''
cimport StatsCalcCython

'''
Despite the cdef keyword being used, this class will be instantiable from Python code.
'''
cdef class StatsCalculator :
    '''
    Define a class to wrap the functionality provided by the C API for StatsCalculator.
    '''
    
    ''' 
    Member data that are declared using the "cdef" keyword cannot be initialized when they
    are declared and cannot be accessed from Python code.
    
    The cdef keyword is required if a type must be specified for a member datum. In this case
    statsCalcHandle will be assigned the result of the C API function statsCalcCreate() which
    is of type int.
    '''
    cdef int statsCalcHandle;
    
    '''
    Cython classes may elect to define constructors using the __cinit__ identifier.
    Unlike __init__, __cinit__ is guaranteed to be called when the class is constructed.
    
    This provides insurance that memory allocated by the StatsCalculator library is
    properly initialized if a subclass of StatsCalculator neglects to explicitly
    call StatsCalculator.__init__.
    '''
    def __cinit__(self):
        self.statsCalcHandle = StatsCalcCython.statsCalcCreate()
        print "Handle is",self.statsCalcHandle
    
    '''
    Although Python classes do not normally require a destructor, it is possible to delcare
    one using the special "__dealloc__" identifier. In this case, the destructor is used to
    explicitly deallocate the memory that is allocated to the StatsCalculator instance 
    that this class wraps.
    '''
    def __dealloc__(self):
        StatsCalcCython.statsCalcDestroy(self.statsCalcHandle)
    
    '''
    Method definitions in Cython code may begin with one of three keywords
    
    1) The standard Python "def" keyword can be used to define methods that can 
       be invoked from the Python or IPython interpreters, but NOT from other 
       Cython code. It results in the poorest performance.
    2) The Cython "cdef" keyword is used to define methods that can ONLY be
       called from other Cython code, and NOT from Python or IPython interpreters.
       It provides the fastest performance.
    3) The Cython "cpdef" keyword may be used to define methods that can be
       invoked from BOTH other Cython code AND the Python or IPython interpreters.
       It provides intermediate performance results in slightly larger comipiled
       file sizes.
       
    Use "def" or "cpdef" if the method must be invoked from the Python or IPython 
    interpreters.
    
    Use "cdef" or "cpdef" if the method must be invoked from other Cython code.
    
    Method parameters may specify associated types regardless of the keyword used
    to declare them.
    '''
        
    cpdef readFile(self, const char * fileName):
        '''
        Invoke the statsCalcReadFile() function that was declared using the cdef
        keyword in "StatsCalcCython.pxd". The code that implements statsCalcReadFile()
        is retrieved from the "libStatsCalculatorCAPI.so" shared library.
        '''
        StatsCalcCython.statsCalcReadFile(self.statsCalcHandle, fileName)
    
    cpdef appendValue(self, double value):
        StatsCalcCython.statsCalcAppendValue(self.statsCalcHandle, value)
    
    '''
    Defining methods that do not directly map to functions in the StatsCalculator
    C API is also permitted. In this case a Python sequence of numeric values is 
    used to append multiple data into the StatsCalculator instances data vector.
    
    It is good practice (but not required) to explicitly identify method 
    parameters accepting Python types (e.g. list, tuple, numpy.array etc) by 
    specifying the "object" type.
    '''
    cpdef appendValues(self, object numberSequence):
        '''
        Function expects that numberSequence argument to be a Python sequence of
        numeric values. It repeatedly invokes the appendValue() method, passing each
        element of numberSequence in succession.
        '''
        for number in numberSequence :
            self.appendValue(number)
    
    cpdef writeStats(self, const char * fileName):
        StatsCalcCython.statsCalcWriteStats(self.statsCalcHandle, fileName)
    
    cpdef double getSum(self):
        return StatsCalcCython.statsCalcGetSum(self.statsCalcHandle)
    
    cpdef double getMean(self):
        return StatsCalcCython.statsCalcGetMean(self.statsCalcHandle)
    
    cpdef double getStdDev(self):
        return StatsCalcCython.statsCalcGetStdDev(self.statsCalcHandle)
