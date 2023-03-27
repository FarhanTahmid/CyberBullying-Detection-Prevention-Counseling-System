from django.urls import path
from parent_organization import views
app_name='parent_organization'

urlpatterns = [
    #landing page
    path('',views.landing_page,name="landing_page")
    
]
