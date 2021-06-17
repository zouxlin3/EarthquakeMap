from django.conf.urls import url
from .views import *


urlpatterns = [
    url('check_latest$', check_latest,),
    url('date_range$', date_range,),
    url('list$', earthquake_list,),
]
