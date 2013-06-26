from django.conf.urls import patterns, include, url
from django.contrib import admin

from .views import Home, RenderTemplate

admin.autodiscover()


urlpatterns = patterns(
    '',

    url(r'^admin/', include(admin.site.urls)),

    url(r'^$', Home.as_view(), name='home'),
    url(r'^templates/(?P<template_name>\w+.*)$', RenderTemplate.as_view(), name='render_template')
)
