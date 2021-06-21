FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="zouxlin3@qq.com"

COPY /backend /backend
COPY /frontend/earthquake_map/dist /frontend
COPY earthquakeMap_nginx.conf /etc/nginx/site-available/default
COPY uwsgi_params /
COPY requirements.txt /
COPY sources.list /etc/apt
COPY supervisor.conf /etc/supervisor/conf.d/

RUN apt update
RUN apt install nginx -y
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple uwsgi
ENV DJANGO_PRODUCTION=1

RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian10-4.4.6.tgz
RUN tar -zxvf mongodb-linux-x86_64-debian10-4.4.6.tgz
RUN mv mongodb-linux-x86_64-debian10-4.4.6 /mongodb
RUN rm -f mongodb-linux-x86_64-debian10-4.4.6.tgz
RUN mkdir -p /var/lib/mongo
RUN mkdir -p /var/log/mongodb
RUN /mongodb/bin/mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork

RUN mkdir data

EXPOSE 8000

RUN apt install supervisor -y
ENTRYPOINT ["supervisord", "-n"]