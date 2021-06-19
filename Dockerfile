FROM alpine

LABEL author="zouxlin3"
LABEL maintainer="edisonzhou.cn"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache python3.8 python3-dev python3-pip
RUN apk add nodejs npm
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install -g @vue/cli

WORKDIR /eMap
COPY . .
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt

WORKDIR /eMap/backend
RUN python manage.py makemigrations api
RUN python manage.py migrate
RUN python manage.py runserver localhost:5000
