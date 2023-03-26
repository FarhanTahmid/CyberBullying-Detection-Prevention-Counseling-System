from django.contrib import admin
from .models import Organization_type,Parent_organization
# Register your models here.

@admin.register(Organization_type)
class Organization_type(admin.ModelAdmin):
    '''Registering Organization Type in admin panel'''
    list_display=['id','type']

@admin.register(Parent_organization)
class Parent_organization(admin.ModelAdmin):
    '''Registering Parent Organizations in Model Admin'''
    list_display=['id','name','type']



