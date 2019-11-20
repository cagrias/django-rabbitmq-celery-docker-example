from django.urls import path

from api import views

app_name = 'api'

urlpatterns = [
    path('publish', views.my_pub_view, name='publish'),
]
