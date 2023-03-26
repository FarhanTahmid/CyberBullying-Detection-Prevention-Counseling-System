# Generated by Django 4.1.7 on 2023-03-26 16:52

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('parent_organization', '0003_delete_parent_organization_users'),
    ]

    operations = [
        migrations.CreateModel(
            name='Parent_organization_users',
            fields=[
                ('user_id', models.CharField(max_length=50, primary_key=True, serialize=False)),
                ('full_name', models.CharField(max_length=100)),
                ('birth_date', models.DateField(blank=True, null=True)),
                ('contact_no', models.CharField(blank=True, max_length=20, null=True)),
                ('email_address', models.EmailField(blank=True, max_length=254, null=True)),
                ('home_address', models.CharField(blank=True, max_length=200, null=True)),
                ('gender', models.CharField(blank=True, max_length=10, null=True)),
                ('organization_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='parent_organization.parent_organization')),
            ],
            options={
                'verbose_name': 'Organization Registered User',
            },
        ),
    ]
