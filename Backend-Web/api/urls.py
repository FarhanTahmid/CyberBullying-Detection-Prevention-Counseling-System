from django.urls import path
from .views import Signup,Login,User_Authentication,User_Complain_Registration,Get_User_Profile,TestImagetoText,ChatBot
from .views import ComplainTypes,Details_of_complains_Lodged_by_user
app_name='api'

urlpatterns = [
    path('signup/', Signup.as_view(), name='signup'),
    path('login/',Login.as_view(),name='login'),
    path('authentication/',User_Authentication.as_view(),name='authentication'),
    path('complain_reg/',User_Complain_Registration.as_view(),name='complain_reg'),
    path('complain_types/',ComplainTypes.as_view(), name="complain_type"),
    path('user_details/<str:user_id>',Get_User_Profile.as_view(),name='user_details'),
    path('user_complains/<str:user_id>',Details_of_complains_Lodged_by_user.as_view(),name="complain_details"),
    path('test_image',TestImagetoText.as_view(),name="image_to_text"),
    path('chatbot',ChatBot.as_view(),name="chatbot")
       
]
