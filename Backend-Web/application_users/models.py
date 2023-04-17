from django.db import models
from django.urls import reverse

from parent_organization.models import Parent_organization

# Create your models here.

class Parent_organization_users(models.Model):
    '''
    Stores the user informations of parent organization's users
    -uses their user_id as primary key
    -foreignKey: Parent_organization_id, to solely identify which organization the user belongs to
    -stores the necessary basic informations needed for a profile
    -stores if the user is proctor or not
    '''
    
    user_id=models.CharField(null=False,blank=False,primary_key=True,max_length=50)
    organization_id=models.ForeignKey(Parent_organization,null=False,blank=False,on_delete=models.CASCADE)
    full_name=models.CharField(null=False,blank=False,max_length=100)
    birth_date=models.DateField(null=True,blank=True)
    contact_no=models.CharField(null=True,blank=True,max_length=20)
    email_address=models.EmailField(null=True,blank=True)
    home_address=models.CharField(null=True,blank=True,max_length=200)
    gender=models.CharField(null=True,blank=True,max_length=10)
    is_proctor=models.BooleanField(null=False,blank=False,default=False)
    
    
    class Meta:
        verbose_name="Organization Registered User"
    def __str__(self) -> str:
        return self.user_id
    def get_absolute_url(self):
        return reverse("user", kwargs={"user_id": self.user_id})
    