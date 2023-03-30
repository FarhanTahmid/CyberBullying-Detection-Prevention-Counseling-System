from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password

class Signup(APIView):
    def post(self, request):
        data = request.data
        username = data.get('username')
        password = data.get('password')
        email = data.get('email')

        # Check if the username and email are already taken
        if User.objects.filter(username=username).exists() or User.objects.filter(email=email).exists():
            return Response({'error': 'Username or email already exists','status':400}, status=status.HTTP_400_BAD_REQUEST)
        
        # Create a new user
        user = User.objects.create(
            username=username,
            email=email,
            password=make_password(password)
        )
        user.save()
        return Response({'success': 'User created successfully'}, status=status.HTTP_201_CREATED)

