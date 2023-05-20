# -*- coding: utf-8 -*-
#!/usr/bin/env python
"""
Created on Tue Jun 23 01:55:33 2020

@author: asure
"""
import numpy as np
import matplotlib.pyplot as plt

plt.style.use(['science'])
scan = np.loadtxt('rates.dat')

Temp = scan[:,1]
I = scan[:,2]
R = scan[:,3]
S=5000-I-R

#
fig=plt.figure(10,(10,8))



plt.title(r'Population time series',fontsize=16)
plt.xlabel(r'time',fontsize = 16)
plt.ylabel(r'Population',fontsize = 16)
plt.plot(Temp, I, '-.',color='red',
              label='I');
plt.plot(Temp, R, '-.',color='blue',
             label='R');

plt.plot(Temp, S, '-.',color='green',
             label='S');

             
plt.legend(loc='best',fontsize=15)
plt.xlim(0,8)

plt.show()
plt.clf()
###########################################################################
