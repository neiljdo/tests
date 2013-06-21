import datetime

from django.db import models

from .managers import LogEntryManager


class Project(models.Model):
    name = models.CharField(max_length=100)
    members = models.ManyToManyField('auth.User', null=True, blank=True)

    def __unicode__(self):
        return u'%s' % self.name

    @property
    def total_hours(self):
        return self.logentry_set.aggregate(total=models.Sum('duration'))['total']


class LogEntry(models.Model):
    user = models.ForeignKey('auth.User', related_name='logs')
    project = models.ForeignKey('logger.Project', null=True, on_delete=models.SET_NULL)
    duration = models.DecimalField(decimal_places=2, max_digits=4)
    date = models.DateField(default=datetime.date.today())            # when the actual work for a log was done
    date_created = models.DateField(auto_now_add=True)
    remarks = models.CharField(max_length=500)

    objects = LogEntryManager()

    class Meta:
        verbose_name_plural = u'Log entries'

    @property
    def is_late(self):
        return self.date_created > self.date
