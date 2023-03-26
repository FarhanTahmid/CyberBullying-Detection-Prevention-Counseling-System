from django.contrib import admin
from .models import Organization_type,Parent_organization,Parent_organization_users
# Register your models here.

@admin.register(Organization_type)
class Organization_type(admin.ModelAdmin):
    '''Registering Organization Type in admin panel'''
    list_display=['id','type']

@admin.register(Parent_organization)
class Parent_organization(admin.ModelAdmin):
    '''Registering Parent Organizations in Model Admin'''
    list_display=['id','name','type']
    
@admin.register(Parent_organization_users)
class Parent_organization_Users(admin.ModelAdmin):
    '''Registering Parent Organization users in Model Admin'''
    list_display=['user_id','organization_id','full_name','email_address','gender']
    



