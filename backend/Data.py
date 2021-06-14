import requests
import os


class Data:
    def __init__(self, starttime: str, endtime: str, minmagnitude: str):
        self.starttime = self.__format_time(starttime)
        self.endtime = self.__format_time(endtime)
        self.minmagnitude = minmagnitude
        self.url = 'https://earthquake.usgs.gov/fdsnws/event/1/query.csv?starttime='+self.starttime+'&endtime='\
                   +self.endtime+'&minmagnitude='+minmagnitude+'&orderby=time'

    def __format_time(self, time: str) -> str:
        time = time.split(' ')
        return time[0]+'%20'+time[1]

    def download(self, filename: str):
        res = requests.get(self.url)
        filepath = os.path.join('..', 'data', filename)  # 保存到上一级目录下的data文件夹
        with open(filepath, 'wb') as f:
            f.write(res.content)
