# -*- coding: utf-8 -*-
#!/usr/bin/env python
"""
Created on Tue Jun 23 01:55:33 2020

@author: asure
"""
import numpy as np
import matplotlib.pyplot as plt

plt.style.use(['science'])
scan = np.loadtxt('comparatives_size.dat')

Temp = scan[:,0]

I = scan[:,1]
I1 = scan[:,2]
I2 = scan[:,3]


#
fig=plt.figure(10,(10,8))



plt.title(r'Infected size $I/N$',fontsize=16)
plt.xlabel(r'$\lambda$/$\gamma$',fontsize = 16)
plt.ylabel(r'$I/N$',fontsize = 16)
plt.plot(Temp, I, '-.',color='red',
              label=r'$<k>=6$');
plt.plot(Temp, I1, '-.',color='green',
              label=r'$<k>=2$');
plt.plot(Temp, I2, '-.',color='orange',
              label=r'$<k>=2$ +contact tracing');


             
plt.legend(loc='best',fontsize=15)
plt.xlim(0,3.5)

plt.show()
plt.clf()
###########################################################################
scan = np.loadtxt('comparative_ntwks.dat')

Temp = scan[:,0]

I = scan[:,1]
I1 = scan[:,2]
I2 = scan[:,3]


#
fig=plt.figure(10,(10,8))



plt.title(r'Infected size $I/N$',fontsize=16)
plt.xlabel(r'$\lambda$/$\gamma$',fontsize = 16)
plt.ylabel(r'$I/N$',fontsize = 16)
plt.plot(Temp, I1, '-.',color='green',
              label=r'Random');
plt.plot(Temp, I2, '-.',color='orange',
              label=r'Power Law $\gamma = 2.7$');
plt.plot(Temp, I, '-.',color='red',
              label=r'Small World');


             
plt.legend(loc='best',fontsize=15)
plt.xlim(0,5)

plt.show()
plt.clf()
