from django.views.decorators.http import require_http_methods
from django.http import HttpResponse, JsonResponse
from django.core import serializers

from .models import Earthquake
import time
import pandas as pd
import json
from Data import Data


@require_http_methods(['GET'])
def check_latest(requset):
    now = pd.Timestamp(time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time())))
    latest = Earthquake.objects.last().time
    if now != latest:
        data = Data(str(latest), str(now), 2.5)
        filename = 'data.csv'
        data.download(filename, 1)
    return HttpResponse(status=200)

@require_http_methods(['GET'])
def date_range(request):
    start = Earthquake.objects.first().time
    end = Earthquake.objects.last().time
    res = str(start.year)+'-'+str(start.month)+'-'+str(start.day)+'>>>' +\
          str(end.year)+'-'+str(end.month)+'-'+str(end.day)
    return HttpResponse(res)


@require_http_methods(['GET'])
def earthquake_list(request):
    res = {'list': []}

    start = request.GET.get('start')
    end = request.GET.get('end')

    earthquakes = Earthquake.objects.filter(time__range=(start, end))

    j = 0
    for i in earthquakes:
        res['list'].append({
            'id': i.id,
            'time': i.time,
            'latitude': i.latitude,
            'longitude': i.longitude,
            'mag': i.mag
        })
        j = j + 1
    res['length'] = j

    return JsonResponse(res)
