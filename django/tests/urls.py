from django.conf.urls import patterns, include, url
from django.contrib import admin

from . import views

admin.autodiscover()


urlpatterns = patterns(
    '',

    url(r'^admin/', include(admin.site.urls)),

    url(r'^user/(?P<pk>\d+)', views.UserDetailView.as_view(), name='user_detail'),
)
