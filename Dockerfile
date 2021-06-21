FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="zouxlin3@qq.com"

RUN apt update
RUN apt install nginx -y

COPY /backend /backend
COPY /frontend/earthquake_map/dist /frontend
COPY earthquakeMap_nginx.conf /
COPY requirements.txt /

RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple uwsgi

RUN mkdir data
EXPOSE 8000

RUN ln -s /earthquakeMap_nginx.conf /etc/nginx/sites-enabled/
RUN /etc/init.d/nginx start

WORKDIR /backend
ENTRYPOINT ["uwsgi", "--ini", "uwsgi.ini"]