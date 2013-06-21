import datetime

from django.contrib.auth.models import User
from django.db.models import Sum

from tastypie import fields
from tastypie.authentication import SessionAuthentication
from tastypie.authorization import Authorization
from tastypie.resources import ModelResource, ALL

from .models import LogEntry, Project


class UserResource(ModelResource):
    class Meta:
        queryset = User.objects.all()


class ProjectResource(ModelResource):
    members = fields.ToManyField('logger.api.UserResource', 'members')

    class Meta:
        queryset = Project.objects.all()
        filtering = {
            'members': ALL
        }


class LogEntryResource(ModelResource):
    user = fields.ForeignKey(UserResource, 'user')
    project = fields.ForeignKey(ProjectResource, 'project')

    class Meta:
        queryset = LogEntry.objects.all()
        authentication = SessionAuthentication()
        authorization = Authorization()
        filtering = {
            'date': ALL
        }
        ordering = ['date']

    def alter_list_data_to_serialize(self, request, data):
        """
        Adds the current user to the returned data.

        """

        data['current_user'] = {
            'pk': request.user.pk,
            'username': request.user.username
        }

        viewed_date = datetime.datetime.strptime(
            request.GET['date'],
            '%Y-%m-%d'
        )
        data['viewed_date'] = request.GET['date']

        # compute the daily total
        daily_qs = LogEntry.objects.for_date(
            viewed_date,
            user=request.user
        )
        data['daily_total'] = daily_qs.aggregate(total=Sum('duration'))['total']

        # compute the weekly total
        weekly_qs = LogEntry.objects.for_week_containing_date(
            viewed_date,
            user=request.user
        )
        data['weekly_total'] = weekly_qs.aggregate(total=Sum('duration'))['total'] or 0

        # compute the monthly total
        monthly_qs = LogEntry.objects.for_month_containing_date(
            viewed_date,
            user=request.user
        )
        data['monthly_total'] = monthly_qs.aggregate(total=Sum('duration'))['total'] or 0

        return data
