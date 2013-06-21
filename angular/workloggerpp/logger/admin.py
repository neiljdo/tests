from django.contrib import admin

from .models import Project, LogEntry


class ProjectAdmin(admin.ModelAdmin):
    list_display = ['__unicode__', 'total_hours']


class LogEntryAdmin(admin.ModelAdmin):
    list_display = ['date_created', 'date', 'duration', 'remarks']


admin.site.register(Project, ProjectAdmin)
admin.site.register(LogEntry, LogEntryAdmin)
