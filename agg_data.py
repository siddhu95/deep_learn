import scipy.io
import numpy as np
from os import listdir,chdir
from os.path import isfile, join

chdir('../original_res/mat_format/')
mypath = 'norm_masked_data/'
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

N = 380;#no of samples
T = 137;#time points;
V = 26949;#voxels after masking

D = np.empty((N*T,V))#Full Dataset
for i,f in enumerate(onlyfiles):
	print i
	d = scipy.io.loadmat('norm_masked_data/000303269784_0003_AO_4_norm.mat')
	D[i*T:((i+1)*T),:] = np.transpose(d['t'])

print 'SIZE of DATA : ' ,np.shape(D)

l = scipy.io.loadmat('class_label.mat')
label = l['class_label']
print D
chdir('../../scripts')