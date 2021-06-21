FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="zouxlin3@qq.com"

COPY /backend /backend
COPY /frontend/earthquake_map/dist /frontend
COPY earthquakeMap_nginx.conf /
COPY uwsgi_params /
COPY requirements.txt /

RUN apt update
RUN apt install nginx -y

RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple uwsgi

RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian10-4.4.6.tgz
RUN tar -zxvf mongodb-linux-x86_64-debian10-4.4.6.tgz
RUN mv mongodb-linux-x86_64-debian10-4.4.6 /mongodb

RUN rm -f mongodb-linux-x86_64-debian10-4.4.6.tgz
RUN mkdir -p /var/lib/mongo
RUN mkdir -p /var/log/mongodb
RUN /mongodb/bin/mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork

RUN mkdir data

EXPOSE 8000

WORKDIR /backend
ENTRYPOINT ["uwsgi", "--ini", "uwsgi.ini"]