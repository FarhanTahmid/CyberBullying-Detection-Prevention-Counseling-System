from django.db import models
from application_users.models import Parent_organization_users
from parent_organization.models import Parent_organization
from django.urls import reverse
# Create your models here.


#User complain Types

class Complain_types(models.Model):
    '''Stores the complain type'''
    complain_type=models.CharField(null=False,blank=False,max_length=30)

    class Meta:
        verbose_name="Complain Type"

    def __str__(self) -> str:
        return str(self.pk)
    def get_absolute_url(self):
        return reverse("complain_type", kwargs={"complain_id": self.pk})
    


class User_Complains(models.Model):
    '''
    Stores all the necessary informations for user complains
    '''
    #complainee_id is the username of the user who is lodging the complain
    complainee_id=models.ForeignKey(Parent_organization_users,null=False,blank=False,on_delete=models.CASCADE)
    #organization_id is the id of the organization from which the user belongs
    organization_id=models.ForeignKey(Parent_organization,null=False,blank=False,on_delete=models.CASCADE)    
    complain_type=models.ForeignKey(Complain_types,null=True,blank=True,on_delete=models.CASCADE)
    bully_name=models.CharField(null=False,blank=False,max_length=50,default="Unknown")
    bully_id=models.CharField(null=True,blank=True,max_length=30)
    bully_picture=models.ImageField(null=True,blank=True,upload_to='bully_pictures/')    
    incident_date=models.DateField(null=True,blank=True)
    complain_description=models.TextField(null=False,blank=False,max_length=1000)
    complain_validation=models.BooleanField(null=False,blank=False,default=False)
    complain_status=models.CharField(null=False,blank=False,default="Processing",max_length=30)
    complain_decision=models.CharField(null=True,blank=True,max_length=500)
    bully_guilty=models.BooleanField(null=True,blank=True,default=False)

    class Meta:
        verbose_name="User Complain"

    def __str__(self) -> str:
        return str(self.pk)
    def get_absolute_url(self):
        return reverse("user_complains", kwargs={"complain_id": self.pk})

class UserComplainProof(models.Model):

    complain_id=models.ForeignKey(User_Complains,null=False,blank=False,on_delete=models.CASCADE)
    proof=models.ImageField(null=True,blank=True,upload_to='complain_proofs/')
    proof_image_to_text=models.CharField(null=True,blank=True,max_length=400)

    class Meta:
        verbose_name = ("Complain Proves")


    def __str__(self):
        return str(self.complain_id)

    def get_absolute_url(self):
        return reverse("complain_id", kwargs={"complain_id": self.complain_id})
    
class JustToTest(models.Model):
    proofName=models.CharField(null=False,blank=False,max_length=100,primary_key=True)
    proof=models.ImageField(null=True,blank=True,upload_to='testing/')
    proof_to_text=models.CharField(null=True,blank=True,max_length=500)
    
    class Meta:
        verbose_name=("Testing Image to Text")
    
    def __str__(self) -> str:
        return self.proofName
    
    def get_absolute_url(self):
        return reverse("proof_name", kwargs={"proof": self.proofName})

    