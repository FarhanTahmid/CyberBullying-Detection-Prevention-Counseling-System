from django.urls import path
from .views import Signup,Login,User_Complain_Registration,User_Profile_Data

app_name='api'

urlpatterns = [
    path('signup/', Signup.as_view(), name='signup'),
    path('login/',Login.as_view(),name='login'),
    path('complain_reg/',User_Complain_Registration.as_view(),name='complain_reg'),
    path('user_details/<str:username>',User_Profile_Data.as_view(),name='user_profile_data'),
    
]
