'''
A Python script with a function definition that includes
type specifications.
'''
def TypedFunction(double doublePar, int numIterations) :
    '''
    The cdef keyword is defined by the Cython language and enables
    types to be specified for variables.
    '''
    cdef double sumOfDoubles = 0 
    '''
    sumOfDoubles is of type "double" (or "float" in Python) even 
    though it was initialized using an integer literal.
    '''
    print "The type of 'sumOfDoubles' is", type(sumOfDoubles)
    
    '''
    Another demonstration that Cython understands Python language 
    constructs.
    '''
    cdef int index = 0
    for index in range(0, numIterations) :
        print "Adding", doublePar,"to sumOfDoubles. Value is now", sumOfDoubles
        sumOfDoubles += doublePar
    
# Initialization for running in "standalone" mode
if __name__ == "__main__" :
    # This will not be displayed in IPython Notebook
    print "__name__ == \"",__name__,"\""
    print "TypedCython loading in standalone..."
else :
    # This will be displayed in IPython Notebook
    print "__name__ == \"",__name__,"\""
    print "TypedCython loading in a Python interpreter..."
    for increment, step in { 1. : 5, 2. : 4, 3. : 3 }.iteritems() :
        print "Running TypedFunction(",increment,",",step,")"
        # Call the function that includes typed variables.
        TypedFunction(increment, step)
