from django.contrib.auth.models import User
from django.views.generic import DetailView


class UserDetailView(DetailView):
    model = User
