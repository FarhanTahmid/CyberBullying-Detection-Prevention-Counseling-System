import csv
from application_users.models import Parent_organization_users
from parent_organization.models import Parent_organization
import django
from django.db import connection

class User_Registration:
    def __init__(self) -> None:
        pass
    def register_user_through_excel():
        '''This function is used to populate Parent_organization_users in the application_users table through CSV files'''
        with open("./Organisation User Data/NSU Student Demo Data/user_data.csv",'r') as file_registered_user:
            fileReader=csv.reader(file_registered_user)
            for row in fileReader:
                if(row[0]=="ï»¿"):
                    continue
                else:
                    try:
                        add_user=Parent_organization_users(
                                        user_id=row[0],
                                        organization_id=Parent_organization.objects.get(id=row[1]) ,
                                        full_name=row[2],
                                        birth_date=row[3],
                                        contact_no=row[4],
                                        email_address=row[5],
                                        home_address=row[6],
                                        gender=row[7],
                                        )
                        add_user.save()
                    except django.db.utils.IntegrityError:
                        continue
                    finally:
                        connection.close()