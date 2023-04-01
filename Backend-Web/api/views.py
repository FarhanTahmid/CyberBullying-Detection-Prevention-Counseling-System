from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User,auth
from application_users.models import Parent_organization_users
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

        print(username)
        print(password)

        user=auth.authenticate(username=username,password=password)
        
        if user is not None:
            auth.login(request,user)
            return Response({'success': 'Logged in successfully','username':username}, status=status.HTTP_202_ACCEPTED)
        else:
            return Response({'error': 'Login unsuccessful'}, status=status.HTTP_401_UNAUTHORIZED)



        