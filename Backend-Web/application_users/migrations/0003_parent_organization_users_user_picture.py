# Generated by Django 4.1.7 on 2023-04-18 08:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('application_users', '0002_parent_organization_users_is_proctor'),
    ]

    operations = [
        migrations.AddField(
            model_name='parent_organization_users',
            name='user_picture',
            field=models.ImageField(blank=True, default='user_pictures/default_picture.png', null=True, upload_to='user_pictures/'),
        ),
    ]
