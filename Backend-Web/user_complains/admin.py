from django.contrib import admin
from . models import User_Complains
# Register your models here.

@admin.register(User_Complains)
class User_Complains(admin.ModelAdmin):
    '''Registering user complains in django admin panel'''
    list_display=['complainee_id','organization_id','complain_type','bully_name',
                  'incident_date','complain_status','bully_guilty']