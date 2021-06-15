from django.shortcuts import render
from django.views.decorators.http import require_http_methods
from django.http import HttpResponse

from models import Earthquake
import time
import pandas as pd
from backend.Data import Data


@require_http_methods(['GET'])
def check_latest(requset):
    now = pd.Timestamp(time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time())))
    latest = Earthquake.objects.last()['time']
    if now != latest:
        data = Data(str(latest), str(now), 2.5)
        filename = 'data.csv'
        data.download(filename)
    return HttpResponse(status=200)
