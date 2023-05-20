# -*- coding: utf-8 -*-
#!/usr/bin/env python
"""
Created on Tue Jun 23 01:55:33 2020

@author: asure
"""
import numpy as np
import matplotlib.pyplot as plt

plt.style.use(['science'])
scan = np.loadtxt('rates_6.dat')
scan1 = np.loadtxt('rates_4.dat')
scan2 = np.loadtxt('rates_3.dat')
scan3 = np.loadtxt('rates_3masc.dat')
scan4 = np.loadtxt('rates_3masc_trac.dat')

Temp = scan[:,1]
Temp1 = scan1[:,1]
Temp2 = scan2[:,1]
Temp3 = scan3[:,1]
Temp4 = scan4[:,1]

I = scan[:,2]
I1 = scan1[:,2]
I2 = scan2[:,2]
I3 = scan3[:,2]
I4 = scan4[:,2]

R = scan[:,3]
R1 = scan1[:,3]
R2 = scan2[:,3]
R3 = scan3[:,3]
R4 = scan4[:,3]

S=5000-I-R

#
fig=plt.figure(10,(10,8))



plt.title(r'Infected time series',fontsize=16)
plt.xlabel(r'time(weeks)',fontsize = 16)
plt.ylabel(r'Infected Population',fontsize = 16)
plt.plot(Temp, I, '-.',color='red',
              label=r'$<k>=6$');
plt.plot(Temp1, I1, '-.',color='blue',
              label=r'$<k>=4$');
plt.plot(Temp2, I2, '-.',color='green',
              label=r'$<k>=2$');
plt.plot(Temp3, I3, '-.',color='orange',
              label=r'$<k>=2$ + mask');
plt.plot(Temp4, I4, '-.',
              label=r'$<k>=2$ + mask + contact tracing');


             
plt.legend(loc='best',fontsize=15)
plt.xlim(0,10)

plt.show()
plt.clf()
###########################################################################
fig=plt.figure(10,(10,8))



plt.title(r'Recovered time series',fontsize=16)
plt.xlabel(r'time(weeks)',fontsize = 16)
plt.ylabel(r'Recovered Population',fontsize = 16)
plt.plot(Temp, R, '-.',color='red',
              label=r'$<k>=6$');
plt.plot(Temp1, R1, '-.',color='blue',
              label=r'$<k>=4$');
plt.plot(Temp2, R2, '-.',color='green',
              label=r'$<k>=2$');
plt.plot(Temp3, R3, '-.',color='orange',
              label=r'$<k>=2$ + mask');
plt.plot(Temp4, R4, '-.',
              label=r'$<k>=2$ + mask + contact tracing');


             
plt.legend(loc='best',fontsize=15)
plt.xlim(0,10)

plt.show()
plt.clf()
fig=plt.figure(10,(10,8))

plt.title(r'Susceptible time series',fontsize=16)
plt.xlabel(r'time(weeks)',fontsize = 16)
plt.ylabel(r'Susceptible Population',fontsize = 16)
plt.plot(Temp,5000-I- R, '-.',color='red',
              label=r'$<k>=6$');
plt.plot(Temp1, 5000-I1- R1, '-.',color='blue',
              label=r'$<k>=4$');
plt.plot(Temp2, 5000-I2- R2, '-.',color='green',
              label=r'$<k>=2$');
plt.plot(Temp3, 5000-I3- R3, '-.',color='orange',
              label=r'$<k>=2$ + mask');
plt.plot(Temp4, 5000-I4- R4, '-.',
              label=r'$<k>=2$ + mask + contact tracing');


             
plt.legend(loc='best',fontsize=15)
plt.xlim(0,10)

plt.show()
plt.clf()
