# -*- coding: utf-8 -*-
"""
Created on Fri Apr 21 16:21:21 2023

@author: farha
"""

import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as splt
import string 
import seaborn as sns
from plotly.offline import download_plotlyjs,init_notebook_mode,plot,iplot
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import re
import nltk
from nltk.stem import PorterStemmer
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from sklearn.metrics import accuracy_score,classification_report,confusion_matrix
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.pipeline import Pipeline
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import LinearSVC
from sklearn import metrics
from sklearn.ensemble import RandomForestClassifier
from sklearn.naive_bayes import MultinomialNB
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn import tree
import warnings
from os import path
from PIL import Image
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
import pandas as pd
import io

def remove_punctuation_from_sentence(sentence):
    sentence_without_punctuation="".join([c for c in sentence if c not in string.punctuation])
    return sentence_without_punctuation


rstate=10

#Loading the dataset

df = pd.read_csv(r"G:\OneDrive - northsouth.edu\CODES\PROJECTS\PROJECT-CSE299-CYBERBULLYING PREVENTION-DETECTION and MENTAL COUNSELING SYSTEM\Machine Learning Models\Bengali hate speech.csv")
df.sample(frac=1)

#removing punctuations
df['sentence without punctuation'] = df['sentence'].apply(lambda x:remove_punctuation_from_sentence(x))
df.head()
