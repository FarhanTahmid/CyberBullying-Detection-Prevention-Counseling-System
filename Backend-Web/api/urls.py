from django.urls import path
from .views import Signup,Login,User_Authentication,User_Complain_Registration,Get_User_Profile

app_name='api'

urlpatterns = [
    path('signup/', Signup.as_view(), name='signup'),
    path('login/',Login.as_view(),name='login'),
    path('authentication/',User_Authentication.as_view(),name='authentication'),
    path('complain_reg/',User_Complain_Registration.as_view(),name='complain_reg'),
    path('user_details/<str:user_id>',Get_User_Profile.as_view(),name='user_details'),
       
]
