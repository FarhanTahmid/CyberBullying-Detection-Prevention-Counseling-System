from rest_framework.views import APIView
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User,auth
from application_users.models import Parent_organization_users
from user_complains.models import User_Complains,Complain_types,UserComplainProof
from parent_organization.models import Parent_organization
from user_complains.models import User_Complains
from django.contrib.auth.hashers import make_password
import pytesseract
from PIL import Image
import requests
from dotenv import load_dotenv
import os
import openai
load_dotenv()
openai.api_key=os.environ.get('chat_gpt_api')



class Signup(APIView):
    def post(self, request):
        data = request.data
        username = data.get('username')
        password = data.get('password')
        email = data.get('email')

        # Check if the username and email are already taken
        if User.objects.filter(username=username).exists() or User.objects.filter(email=email).exists():
            return Response({'error': 'Username or email already exists'}, status=status.HTTP_400_BAD_REQUEST)
        
        # Create a new user if only a member is registered in the organisation database
        try:
            Parent_organization_users.objects.get(user_id=username)
            user = User.objects.create(
                username=username,
                email=email,
                password=make_password(password)
            )
            user.save()
            return Response({'success': 'User created successfully'}, status=status.HTTP_201_CREATED)

        except:
            Parent_organization_users.DoesNotExist
            return Response({'error': 'Username Does not exist in the Organisation Database!'}, status=status.HTTP_205_RESET_CONTENT)

class Login(APIView):
    def post(self,request):
        data=request.data
        username=data.get('username')
        password=data.get('password')

        user=authenticate(username=username,password=password)
        
        if user is not None:
            refresh=RefreshToken.for_user(user=user)
            return Response({'success': 'Logged in successfully','username':username,'token':str(refresh.access_token)}, status=status.HTTP_202_ACCEPTED)
        else:
            return Response({'error': 'Login unsuccessful'}, status=status.HTTP_401_UNAUTHORIZED)

class User_Authentication(APIView):
    
    @api_view(['GET'])
    @authentication_classes([TokenAuthentication])
    @permission_classes([IsAuthenticated])
    def get(request):
        authenticated = True
        # Perform any additional checks or operations here
        return Response({'authenticated': authenticated}, status=status.HTTP_200_OK)
            


class User_Complain_Registration(APIView):
    parser_classes = [MultiPartParser, FormParser]
    
    def post(self,request):
        
        data=request.data
        #get the current user
        complainee_id=data.get('user_id')
        bully_picture = request.FILES.get('bully_image')
        image_proves=request.FILES.getlist('image_proves')
        
        #get user data
        try:
            get_user_data=Parent_organization_users.objects.get(user_id=complainee_id)
            
            #get organization id
            organization_id=get_user_data.organization_id
        except:
            return Response({'error': 'Complain Lodging unsuccessful because id doesnt exist.'}, status=status.HTTP_406_NOT_ACCEPTABLE)

        complain_type=Complain_types.objects.filter(complain_type=data.get('harrasment_type')).values('pk')
        
        #register a complain now
        try:
            new_complain=User_Complains(
                complainee_id=Parent_organization_users.objects.get(user_id=complainee_id),
                organization_id=Parent_organization.objects.get(id=organization_id.id),
                complain_type=Complain_types.objects.get(pk=complain_type[0]['pk']),
                bully_name=data.get('bully_name'),
                bully_id=data.get('bully_id'),
                bully_picture=bully_picture,
                incident_date=data.get('incident_date'),
                complain_description=data.get('description') 
            )
            new_complain.save()
            for image in image_proves:
                upload_proves=UserComplainProof(
                    complain_id=User_Complains.objects.get(pk=new_complain.pk),
                    proof=image
                )
                upload_proves.save()
            return Response({'success': 'Complain Lodged successfully'}, status=status.HTTP_202_ACCEPTED)    
        except:
            return Response({'error': 'Complain Lodging unsuccessful'}, status=status.HTTP_400_BAD_REQUEST)
    
class Get_User_Profile(APIView):
    
    def post(self,request,user_id):
        data=request.data
        #get the values which will be updates
        full_name=data.get('full_name')
        email_address=data.get('email_address')
        contact_no=data.get('contact_no')
        home_address=data.get('home_address')
        
        # update values
        try:
            user=Parent_organization_users.objects.get(user_id=user_id)
            user.full_name=full_name
            user.email_address=email_address
            user.contact_no=contact_no
            user.home_address=home_address
            user.save()
            
            return Response({'success': 'Edited Profile Info'}, status=status.HTTP_200_OK)
        except:
            return Response({'error': 'Can not edit Profile Infor'}, status=status.HTTP_400_BAD_REQUEST)

    def get(self,request,user_id):

        #get user profile and id
        # current_user=request.user
        # username=current_user.username
        # print(f"The username is {username}")

        try:
            get_user_data=Parent_organization_users.objects.get(user_id=user_id)
            username=get_user_data.user_id
            organization_name=get_user_data.organization_id.name
            full_name=get_user_data.full_name
            user_picture='/media_files/'+str(get_user_data.user_picture)
            birth_date=get_user_data.birth_date
            contact_no=get_user_data.contact_no
            email_address=get_user_data.email_address
            home_address=get_user_data.home_address
            gender=get_user_data.gender
            is_proctor=get_user_data.is_proctor
            

            return Response({'success': 'User found',
                             'user_id':username,
                             'organization_name':organization_name,
                             'full_name':full_name,
                             'user_picture':user_picture,
                             'birth_date':birth_date,
                             'contact_no':contact_no,
                             'email_address':email_address,
                             'home_address':home_address,
                             'gender':gender,
                             'is_proctor':is_proctor,
                             }, status=status.HTTP_202_ACCEPTED)
        
        except:
            return Response({'error': 'User not found'}, status=status.HTTP_400_BAD_REQUEST)
        
class Details_of_complains_Lodged_by_user(APIView):
    
    def get(self,request,user_id):

        get_complains=User_Complains.objects.filter(complainee_id=user_id).values()
        return Response({'success': 'Complains loaded',
                         'complains':get_complains}
                         , status=status.HTTP_200_OK)


class ComplainTypes(APIView):
    
    def get(self,request):
        complain_types=Complain_types.objects.all()
        typeDict={}
        
        for type in complain_types:
            typeDict.update({type.pk:type.complain_type})
        return Response({'success':'Got types','types':typeDict},status=status.HTTP_200_OK)



class User_Profile_Data(APIView):
    
    def get(self,request,username):
        
        user_details=Parent_organization_users.objects.get(user_id=username)
        print(user_details)
        return Response({'success':'Got data','username':user_details.full_name},status=status.HTTP_202_ACCEPTED)
    

class TestImagetoText(APIView):
    def post(self,request,*args,**kwargs):
        
        data=request.data
        image_file=data.get('image')
        print(image_file)
        image=Image.open(image_file)
        # pytesseract.pytesseract.tesseract_cmd = r'F:\Tesseract\tesseract.exe'
        pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
        text=pytesseract.image_to_string(image=image)
        print(text)
        return Response({'success':'Got data','text':text},status=status.HTTP_202_ACCEPTED)





class ChatBot(APIView):
    
    def post(self,request):
        
        data=request.data
        user_prompt=data['user_message']
        prompt=user_prompt
        try:
            response=openai.Completion.create(
                engine='text-davinci-003',
                prompt=prompt,
                max_tokens=256,
                temperature=0.7,
            )
            
            return Response({'success':'Got chatGPT','ai_message':response["choices"][0]["text"]},status=status.HTTP_200_OK)
        except:
            return Response({'error': 'No chatGPT'}, status=status.HTTP_400_BAD_REQUEST)
            
        

     
        
       

        