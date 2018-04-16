from scipy.ndimage.fourier import fourier_gaussian
import numpy
import scipy

print('numpy version:', numpy.__version__)
print('scipy version:', scipy.__version__)

print('fourier_gaussian:', fourier_gaussian(numpy.ones([1, 1]), 1))
