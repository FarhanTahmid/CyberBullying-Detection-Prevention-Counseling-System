from django.shortcuts import render
from parent_organization.register_user import User_Registration
import requests 
from langdetect import detect
# Create your views here.

def landing_page(request):
    # User_Registration.register_user_through_excel()
    # url = "https://acobot-brainshop-ai-v1.p.rapidapi.com/get"

    # querystring = {"bid":"178","key":"sX5A2PcYZbsN5EY6","uid":"mashape","msg":"Hello!"}

    # headers = {
    #     "X-RapidAPI-Key": "40a5861dd4msh8b53f127753bb4ap124b63jsna62fc39f423d",
    #     "X-RapidAPI-Host": "acobot-brainshop-ai-v1.p.rapidapi.com"
    # }

    # response = requests.get(url, headers=headers, params=querystring)

    # print(response.json())
       
    return render(request,'landing_page.html')

def detect_language(text):
    #returns en for english and bn for bangla
    try:
        lang = detect(text)
        return lang
    except:
        return None
