FROM python:3.8

LABEL author="zouxlin3"
LABEL maintainer="zouxlin3@qq.com"

WORKDIR /backend
COPY . .

RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -r requirements.txt
RUN pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple uwsgi

RUN mkdir /data

EXPOSE 5000

COPY sources.list /etc/apt
RUN apt update
RUN apt install supervisor -y
COPY em_b_supervisor.conf /etc/supervisor/conf.d
ENTRYPOINT ["supervisord", "-n"]