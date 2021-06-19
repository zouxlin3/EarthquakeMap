FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="edisonzhou.cn"

RUN apt update
RUN apt install nodejs npm -y
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install -g @vue/cli

WORKDIR /eMap
COPY . .
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt

WORKDIR /eMap/backend
RUN mkdir data

EXPOSE 8080
