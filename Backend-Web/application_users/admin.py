from django.contrib import admin
from .models import Parent_organization_users

# Register your models here.

@admin.register(Parent_organization_users)
class Parent_organization_Users(admin.ModelAdmin):
    '''Registering Parent Organization users in Model Admin'''
    list_display=['user_id','organization_id','full_name','email_address','gender']