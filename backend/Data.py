import pandas as pd
import requests
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'django_vue.settings')
import django
django.setup()
from api.models import Earthquake
from django.utils.timezone import make_aware, make_naive


class Data:
    def __init__(self, starttime: str, endtime: str, minmagnitude: float):
        self.starttime = starttime
        self.endtime = endtime
        self.minmagnitude = minmagnitude

    def __format_time(self, time: str) -> str:
        time = time.split(' ')
        return time[0]+'%20'+time[1]

    def download(self, filename: str, days: int):
        start = self.__change2naive(pd.Timestamp(self.starttime))
        end = self.__change2naive(pd.Timestamp(self.endtime))
        delta = pd.Timedelta(days=days)

        i = 1
        while True:
            start_plus = start + delta
            if start_plus > end:
                break

            url = 'https://earthquake.usgs.gov/fdsnws/event/1/query.csv?starttime='+self.__format_time(str(start))\
                  + '&endtime=' + self.__format_time(str(start_plus))+'&minmagnitude='+str(self.minmagnitude) + \
                  '&orderby=time'
            res = requests.get(url)
            filepath = os.path.join(filename)  # 保存到上一级目录下的data文件夹
            with open(filepath, 'wb') as f:
                f.write(res.content)

            self.__add_earthquake(filename)
            print('download times:', i)
            i = i+1

            start = start_plus

    def __add_earthquake(self, filename: str):
        data = pd.read_csv(os.path.join(filename))
        for i in range(data.shape[0]):
            aline = data.iloc(axis=0)[-(i+1)]
            earthquake = Earthquake(latitude=aline['latitude'],
                                    longitude=aline['longitude'],
                                    mag=aline['mag'])
            earthquake.time = make_aware(earthquake.format_time(aline['time']))
            earthquake.save()

    def __change2naive(self, time):
        if time.tzinfo:
            return make_naive(time)
        else:
            return time
