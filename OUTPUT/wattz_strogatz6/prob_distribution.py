# -*- coding: utf-8 -*-
#!/usr/bin/env python
"""
Created on Tue Jun 23 01:55:33 2020

@author: asure
"""
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

test1 = np.loadtxt('rates.dat')


plt.style.use(['science'])

infected = test1[:,2]

fig=plt.figure(12,(12,10))

kwargs = dict(histtype='stepfilled', alpha=0.3, normed=True, bins='auto')
#
plt.title('Infected Probability Distribution',fontsize=16)
plt.xlabel(r'$m=I$',fontsize=16)
plt.ylabel(r'$P(I)$',fontsize=16)

sns.distplot(infected, hist = False, kde = True,
                 kde_kws = {'shade': True, 'linewidth': 2},label=r'$T=Tcrit$')
#sns.distplot(energy2, hist = False, kde = True,
                 #kde_kws = {'shade': True, 'linewidth': 2},label=r'$T<Tcrit$')
#plt.hist(energy1, **kwargs,label=r'$T=Tcrit$')
#plt.hist(energy2, **kwargs,label=,label=r'$T=Tcrit$')
#plt.hist(energy3, **kwargs,label=r'$T>Tcrit$')
plt.legend(loc='upper right',fontsize=16)
plt.show()


