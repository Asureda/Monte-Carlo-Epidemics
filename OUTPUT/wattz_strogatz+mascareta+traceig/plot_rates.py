import numpy as np
import matplotlib.pyplot as plt
from scipy import integrate
from lmfit import Model

data = np.loadtxt('rates.dat')
time = data[:, 1]
I = data[:, 2]
R = data[:, 3]
prob = data[:, 4]
active = 5000 -I-R
plt.xlabel('time')
plt.ylabel('Population')

plt.xlim(0,10)
plt.plot(time, R,'b--',label='R')
plt.plot(time, I,'g--',label='I')
plt.plot(time, active,'r--',label='S')

#plt.scatter(N, end2,marker ="s",
#            edgecolor ="green",label='$< R^{2} >$')

plt.legend(loc='center right')

plt.show()
