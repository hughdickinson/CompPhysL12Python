'''
Cython uses functionality provided by the distutils package to compile
the code it generates and define extensions to the Python language.

Cython does not import the required modules and packages automatically,
so this must be done explicitly
'''
from distutils.core import setup
'''
Import the cythonize function that will generate C code that bridges between
C and Python.
'''
from Cython.Build import cythonize

'''
This invocation of the distutils.core.setup() function generates a Python
module with the filename "TrivialCython.py" which contains all Python-
compatible code that is defined in Cython implementation file 
"TrivialCython.pyx". The module name is generated automatically using the 
base name ("TrivialCython") of the implementation file. 
'''
setup(
    ext_modules = cythonize("TrivialCython.pyx")
)
