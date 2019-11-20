from django.http import HttpResponse

from api import tasks


def my_pub_view(request):
    tasks.publish_message({'hello': 'world'})
    return HttpResponse(status=201)
