from django.contrib import admin
from . models import User_Complains,Complain_types,JustToTest,UserComplainProof
# Register your models here.

@admin.register(Complain_types)
class Complain_types(admin.ModelAdmin):
    list_display=['id','complain_type']

@admin.register(User_Complains)
class User_Complains(admin.ModelAdmin):
    '''Registering user complains in django admin panel'''
    list_display=['complainee_id','organization_id','complain_type','bully_name',
                  'incident_date','complain_status','bully_guilty']

@admin.register(UserComplainProof)
class User_complain_proof(admin.ModelAdmin):
    list_display=[
        'pk','complain_id','proof_image_to_text'
    ]

@admin.register(JustToTest)
class Test(admin.ModelAdmin):
    list_display=[
        'proofName',
        'proof_to_text'
    ]