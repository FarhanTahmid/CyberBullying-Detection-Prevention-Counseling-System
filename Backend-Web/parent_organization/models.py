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
        return str(self.name)
    def get_absolute_url(self):
        return reverse("parent_organization", kwargs={"name":self.pk})


    
