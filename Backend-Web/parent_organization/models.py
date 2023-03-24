from django.db import models
from django.urls import reverse

# Create your models here.

class organization_type(models.Model):
    '''Defines the type of organizations'''
    type=models.CharField(null=False,blank=False,max_length=30)
    


class parent_organization(models.Model):
    '''Defines the parent organizations. The users are going to be affiliated with this'''
    '''The primary keys will be auto generated integer values'''
    
    name=models.CharField(null=False,blank=False,max_length=100)
    type=models.ForeignKey(organization_type,null=False,blank=False,on_delete=models.CASCADE)
    
    class Meta:
        verbose_name="Parent Organization"
    def __str__(self) -> str:
        return self.name
    def get_absolute_url(self):
        return reverse("parent_organization", kwargs={"name":self.name})
