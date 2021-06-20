FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="zouxlin3@qq.com"

RUN apt update
RUN apt install nginx -y

COPY /backend /backend
COPY /frontend/earthquake_map/dist /frontend
COPY nginx.conf /
COPY requirements.txt /

RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple gunicorn

RUN mkdir data
EXPOSE 8000

WORKDIR /backend
ENTRYPOINT ["nohup", "gunicorn", "django_vue.wsgi:application", "-c", "./gunicorn.conf.py"]