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

setup(
    ext_modules = cythonize("TypedCython.pyx")
)
