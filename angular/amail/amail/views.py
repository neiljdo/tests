from django.views.generic import TemplateView


class Home(TemplateView):
    template_name = 'home.html'


class RenderTemplate(TemplateView):
    def get_template_names(self):
        return [self.kwargs.get('template_name')]
