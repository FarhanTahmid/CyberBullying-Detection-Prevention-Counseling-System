from django.db import models
from django.urls import reverse

# Create your models here.

class Organization_type(models.Model):
    '''Defines the type of organizations'''
    type=models.CharField(null=False,blank=False,max_length=30)
    
    class Meta:
        verbose_name="Organization Type"
    def __str__(self) -> str:
        return self.type
    def get_absolute_url(self):
        return reverse("organization_type", kwargs={"type":self.type})


class Parent_organization(models.Model):
    '''Defines the parent organizations. The users are going to be affiliated with this'''
    '''The primary keys will be auto generated integer values'''
    
    name=models.CharField(null=False,blank=False,max_length=100)
    type=models.ForeignKey(Organization_type,null=False,blank=False,on_delete=models.CASCADE)
    
    class Meta:
        verbose_name="Parent Organization"
    def __str__(self) -> str:
        return self.name
    def get_absolute_url(self):
        return reverse("parent_organization", kwargs={"name":self.name})

class Parent_organization_users(models.Model):
    '''
    Stores the user informations of parent organization's users
    -uses their user_id as primary key
    -foreignKey: Parent_organization_id, to solely identify which organization the user belongs to
    -stores the necessary basic informations needed for a profile
    '''
    
    user_id=models.CharField(null=False,blank=False,primary_key=True,max_length=50)
    organization_id=models.ForeignKey(Parent_organization,null=False,blank=False,on_delete=models.CASCADE)
    full_name=models.CharField(null=False,blank=False,max_length=100)
    birth_date=models.DateField(null=True,blank=True)
    contact_no=models.CharField(null=True,blank=True,max_length=20)
    email_address=models.EmailField(null=True,blank=True)
    home_address=models.CharField(null=True,blank=True,max_length=200)
    gender=models.CharField(null=True,blank=True,max_length=10)
    
    
    class Meta:
        verbose_name="Organization Registered User"
    def __str__(self) -> str:
        return self.user_id
    def get_absolute_url(self):
        return reverse("user", kwargs={"user_id": self.user_id})
    
