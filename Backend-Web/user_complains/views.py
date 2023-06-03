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

def detectBanglaCyberBullying(text):
    loaded_model = load_model(r"user_complains/ml-dl-models/bangla-sequential-model.h5")
    
    # load_model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])
    print(text)
    
    text=remove_punctuation_from_sentence(text)
    text=remove_stopwords(text=text,stopwords=stopwords)
    
    print(text)
    
    tokenizer = Tokenizer()
    
    
    sequences = tokenizer.texts_to_sequences([text])
    pdsequences= pad_sequences(sequences, maxlen=100)
    prediction = loaded_model.predict(pdsequences)[0][0]
    predicted_class = (prediction > 0.5).astype(int)
    print(predicted_class)
    # if prediction >= 0.5:
    #     print("HATE")
    # else:
    #     print("not hate")
    
def remove_punctuation_from_sentence(sentence):
    sentence_without_punctuation="".join([c for c in sentence if c not in string.punctuation])
    return sentence_without_punctuation



def detectEnglishCyberBullying(text):
    with open(r'user_complains/ml-dl-models/english-decision-tree-model.pkl', 'rb') as file:
        model = pickle.load(file)
    
    os.add_dll_directory(r'user_complains/ml-dl-models/english-decision-tree-model.pkl')
    
    preprocessed_text = preProcessEnglishText(text)

    # Make predictions using the loaded model
    prediction = model.predict([preprocessed_text])[0]

    # Add your post-processing code here (if needed)

    print(prediction)

def preProcessEnglishText(text):
    # Convert text to lowercase
    text = text.lower()

    # Remove URLs
    text = re.sub(r'http\S+', '', text)

    # Remove numbers and punctuations
    text = re.sub(r'\d+', '', text)
    text = text.translate(str.maketrans('', '', string.punctuation))

    # Add your additional preprocessing steps here (if needed)

    return text