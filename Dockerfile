FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="zouxlin3@qq.com"

RUN apt update
RUN apt install supervisor
RUN apt install nginx

COPY /backend /backend
COPY /frontend/dist /frontend
COPY nginx.conf /
COPY requirements.txt /

RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple gunicorn

RUN mkdir data
WORKDIR /backend
RUN nohup gunicon django_vue.wsgi -b 127.0.0.1:5001
RUN nohup nginx -c /nginx.conf

EXPOSE 80
