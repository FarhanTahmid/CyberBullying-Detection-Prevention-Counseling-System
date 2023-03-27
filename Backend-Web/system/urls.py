from django.urls import path
from system import views
app_name='system'

urlpatterns = [
    #landing page
    path('',views.landing_page,name="landing_page")
    
]
