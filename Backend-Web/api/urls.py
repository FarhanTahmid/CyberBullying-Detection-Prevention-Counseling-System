from django.urls import path
from .views import Signup,Login,User_Complain_Registration

app_name='api'

urlpatterns = [
    path('signup/', Signup.as_view(), name='signup'),
    path('login/',Login.as_view(),name='login'),
    path('complain_reg',User_Complain_Registration.as_view(),name='complain_reg')
    
]
