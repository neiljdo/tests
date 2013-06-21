from django.conf.urls import patterns, include, url

from tastypie.api import Api

from .api import LogEntryResource, UserResource, ProjectResource
from .views import Home

v1_api = Api(api_name='v1')
v1_api.register(UserResource())
v1_api.register(ProjectResource())
v1_api.register(LogEntryResource())

urlpatterns = patterns(
    '',

    url(r'^$', Home.as_view(), name='home'),
    url(r'^api/', include(v1_api.urls))
)