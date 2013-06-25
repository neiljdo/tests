from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.contrib.auth.forms import AuthenticationForm

from .views import Home, RenderTemplate
from logger import urls as logger_urls


admin.autodiscover()

urlpatterns = patterns(
    '',

    url(r'^admin/', include(admin.site.urls)),

    # auth views
    url(r'^accounts/login/$', 'django.contrib.auth.views.login', {'authentication_form': AuthenticationForm}, name='login'),
    url(r'^accounts/logout/$', 'django.contrib.auth.views.logout', {'next_page': '/accounts/login'}, name='logout'),

    url(r'^$', Home.as_view(), name='home'),
    url(r'^', include(logger_urls)),

    url(r'^templates/(?P<template_name>\w+.*)$', RenderTemplate.as_view(), name='render_template')
)
