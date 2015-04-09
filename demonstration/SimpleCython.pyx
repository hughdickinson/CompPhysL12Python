# A simple Python script with a function definition 
def SimpleFunction(stepSize) :
    print "Simple function generated:"
    print [ 2*value for value in range(0, 10, stepSize) ]   
    return

'''
If the module that is generated using this Cython code is used
as a standalone Python script, then the __name__ variable will 
be equal to "__main__" and appropriate initialization code can be 
executed.
'''
if __name__ == "__main__" :
    # This will not be displayed in IPython Notebook
    print "__name__ == \"",__name__,"\""
    print "SimpleCython loading in standalone mode..."
else :
    # This will be displayed in IPython Notebook (or any interpreter)
    print "__name__ == \"",__name__,"\""
    print "SimpleCython loading in a Python interpreter..."
    # invoke SimpleFunction for a few trial argument values
    for step in [1,2,3] :
        print "Running SimpleFunction(",step,")"
        SimpleFunction(step)
