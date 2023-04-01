from django.urls import path
from .views import Signup,Login

app_name='api'

urlpatterns = [
    path('signup/', Signup.as_view(), name='signup'),
    path('login/',Login.as_view(),name='login'),
]
