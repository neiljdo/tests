import datetime

from django.db import models


class LogEntryManager(models.Manager):
    def for_date(self, date, **kwargs):
        return self.model.objects.filter(date=date, **kwargs)

    def for_month_containing_date(self, date, **kwargs):
        return self.model.objects.filter(date__month=date.month, **kwargs)

    def for_week_containing_date(self, date, **kwargs):
        weekday = date.isocalendar()[2]
        start_of_week = date - datetime.timedelta(days=weekday-1)
        end_of_week = date + datetime.timedelta(days=7-weekday)

        return self.model.objects.filter(
            date__lte=end_of_week,
            date__gte=start_of_week,
            **kwargs
        )
