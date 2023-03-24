from django.db import models
from django.urls import reverse

# Create your models here.

class Registered_Institutes_and_Organisations(models.Moel):
    organisation_name=models.CharField(null=False,blank=False,max_length=70)
    
    class Meta:
        verbose_name="Registered Institutes and Organistations"
    
    def __str__(self) -> str:
        return str(self.organisation_name)
    def get_absolute_url(self):
        return reverse("institutes_or_organizations", kwargs={"name": self.organisation_name})

