from django import forms

from .models import LogEntry


class LogEntryForm(forms.ModelForm):
    class Meta:
        model = LogEntry
        fields = ('duration', 'project', 'remarks', 'user', 'date')
        widgets = {
            'user': forms.HiddenInput(),
            'date': forms.HiddenInput(),
        }

    def __init__(self, user, viewed_date, *args, **kwargs):
        super(LogEntryForm, self).__init__(*args, **kwargs)

        self.fields['user'].initial = user
        self.fields['date'].initial = viewed_date


class LogEntryForm2(forms.ModelForm):
    """ Cleaner modelform (no __init__ overrides - DRYer). """

    class Meta:
        model = LogEntry
        fields = ('duration', 'project', 'remarks', 'user', 'date')     # simply for ordering the fields during rendering
        widgets = {
            'user': forms.HiddenInput(),
            'date': forms.HiddenInput(),
        }
