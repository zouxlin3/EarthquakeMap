from djongo import models
import pandas as pd


class Earthquake(models.Model):
    time = models.DateTimeField(auto_now_add=False)
    latitude = models.FloatField()
    longitude = models.FloatField()
    mag = models.FloatField()

    def format_time(self, datetime: str):
        date = datetime[:10]
        time = datetime[11:19]
        return pd.Timestamp(date+' '+time)
