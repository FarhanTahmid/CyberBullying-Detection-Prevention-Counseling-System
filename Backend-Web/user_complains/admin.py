from django.contrib import admin
from . models import User_Complains,Complain_types
# Register your models here.

@admin.register(Complain_types)
class Complain_types(admin.ModelAdmin):
    list_display=['id','complain_type']

@admin.register(User_Complains)
class User_Complains(admin.ModelAdmin):
    '''Registering user complains in django admin panel'''
    list_display=['complainee_id','organization_id','complain_type','bully_name',
                  'incident_date','complain_status','bully_guilty']