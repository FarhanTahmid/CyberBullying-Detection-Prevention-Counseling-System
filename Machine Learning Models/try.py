# -*- coding: utf-8 -*-
"""
Created on Fri Apr 21 16:21:21 2023

@author: farha
"""

import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as splt

#Loading the dataset

df=pd.read_csv('Bengali hate speech.csv')

#loading x and y

x=df['sentence']

y=df['hate']

from sklearn.model_selection import train_test_split
from sklearn.svm import SVC

xtrain,xtest,ytrain,ytest=train_test_split(x,y,test_size=.20,random_state=1)

model=SVC(gamma='auto')

