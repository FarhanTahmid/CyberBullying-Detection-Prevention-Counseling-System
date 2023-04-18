from django.db import models
from application_users.models import Parent_organization_users
from parent_organization.models import Parent_organization
# Create your models here.


class User_Complains(models.Model):
    '''
    Stores all the necessary informations for user complains
    '''
    complainee_id=models.ForeignKey(Parent_organization_users,null=False,blank=False,on_delete=models.CASCADE)
    organization_id=models.ForeignKey(Parent_organization,null=False,blank=False,on_delete=models.CASCADE)    
    complain_type=models.CharField(null=False,blank=False,max_length=30,default="Harassment")
    bully_name=models.CharField(null=False,blank=False,max_length=50,default="Unknown")
    bully_id=models.CharField(null=True,blank=True,max_length=30)
    bully_picture=models.ImageField(null=True,blank=True,upload_to='bully_pictures/')    
    incident_date=models.DateField(null=True,blank=True)
    complain_description=models.TextField(null=False,blank=False,max_length=100)
    complain_status=models.CharField(null=False,blank=False,default="Processing",max_length=30)
    complain_decision=models.CharField(null=True,blank=True,max_length=500)
    bully_guilty=models.BooleanField(null=True,blank=True,default=False)