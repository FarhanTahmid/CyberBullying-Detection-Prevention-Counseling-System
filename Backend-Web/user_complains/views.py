from django.shortcuts import render
from tensorflow import keras
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.models import load_model
import string 
import re
from bnlp.corpus.util import remove_stopwords
from bnlp.corpus import stopwords, punctuations, letters, digits
import pickle
import os

# Create your views here.

