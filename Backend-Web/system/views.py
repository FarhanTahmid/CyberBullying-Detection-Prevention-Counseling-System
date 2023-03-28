from django.shortcuts import render
from parent_organization.register_user import User_Registration
# Create your views here.

def landing_page(request):
    
    return render(request,'landing_page.html')