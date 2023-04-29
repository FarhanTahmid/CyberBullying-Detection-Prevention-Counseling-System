from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User,auth
from application_users.models import Parent_organization_users
from user_complains.models import User_Complains
from parent_organization.models import Parent_organization
from django.contrib.auth.hashers import make_password


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

        user=auth.authenticate(username=username,password=password)
        
        if user is not None:
            auth.login(request,user)
            return Response({'success': 'Logged in successfully','username':username}, status=status.HTTP_202_ACCEPTED)
        else:
            return Response({'error': 'Login unsuccessful'}, status=status.HTTP_401_UNAUTHORIZED)

class User_Complain_Registration(APIView):
    
    def post(self,request):
        data=request.data
        
        #get the current user
        current_user=request.user
        complainee_id=current_user.username
        
        
        #get user data
        try:
            get_user_data=Parent_organization_users.objects.get(user_id=complainee_id)
            
            #get organization id
            organization_id=get_user_data.organization_id
        except:
            return Response({'error': 'Complain Lodging unsuccessful because id doesnt exist.'}, status=status.HTTP_406_NOT_ACCEPTABLE)


        
        #register a complain now
        try:
            new_complain=User_Complains(
                complainee_id=Parent_organization_users.objects.get(user_id=complainee_id),
                organization_id=Parent_organization.objects.get(id=organization_id.id),
                complain_type=data.get('complain_type'),
                bully_name=data.get('bully_name'),
                bully_id=data.get('bully_id'),
                bully_picture=data.get('bully_picture'),
                incident_date=data.get('incident_date'),
                complain_description=data.get('complain_description')
                
            )
            new_complain.save()
            return Response({'success': 'Complain Lodged successfully'}, status=status.HTTP_202_ACCEPTED)    
        except:
            return Response({'error': 'Complain Lodging unsuccessful'}, status=status.HTTP_406_NOT_ACCEPTABLE)



        