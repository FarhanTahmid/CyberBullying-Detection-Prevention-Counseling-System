# Generated by Django 4.1.7 on 2023-05-26 04:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('user_complains', '0004_alter_complain_types_options_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='user_complains',
            name='complain_validation',
            field=models.BooleanField(default=False),
        ),
        migrations.CreateModel(
            name='UserComplainProof',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('proof', models.ImageField(blank=True, null=True, upload_to='complain_proofs/')),
                ('proof_image_to_text', models.CharField(blank=True, max_length=400, null=True)),
                ('complain_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='user_complains.user_complains')),
            ],
            options={
                'verbose_name': 'Complain Proves',
            },
        ),
    ]
