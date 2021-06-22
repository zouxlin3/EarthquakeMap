# EarthquakeMap
# 简介
# 实现功能
# 前端部署
## 上传网站
修改`/frontend/earthquake_map/src/components/`文件夹内的`PointInfo.vue`和`Search.vue`

将api地址改为自己服务器的地址，如果前后端均在本地运行则不需要改动

打包vue项目，上传`/dist`文件夹到服务器

## nginx配置
安装`nginx`和`supervisor`

在`/etc/nginx/sites-available`文件夹新建配置文件`em_f_nginx.conf`(自行更改文件名)

输入以下内容(`root`路径改为自己的)
```
server {
    listen       8000;
    server_name  localhost;

    location / {
        root   /sites/earthquakeMap/dist;
        index  index.html;
    }
}
```
引用配置文件
```shell
ln -s /etc/nginx/sites-available/em_f_nginx.conf  /etc/nginx/sites-enabled
```
设置进程守护

在`/etc/supervisor/conf.d`文件夹新建配置文件`em_f_supervisor.conf`(自行更改文件名)

输入以下内容
```
[supervisord]
nodaemon=true

[program:nginx]
command = nginx
redirect_stderr=true
autostart=true
autorestart=true
stdout_logfile=/stdout
stdout_logfile_maxbytes=0
```
运行进程守护
```shell
supervisord -n
```
# 后端部署
自行安装mongodb数据库，并创建名为`earthquakes`的`database`
## 运行docker容器
```shell
docker pull zouxlin3/earthquake_map_api
docker run --name earthquake_map_api -d -p 5000:5000 zouxlin3/earthquake_map_api
# -p 主机端口:容器端口
```
## 连接数据库
```shell
# 进入容器
docker exec -it earthquake_map_api bash
```
修改`/backend/settings.py`文件的数据库选项，改为自己的配置
```
DATABASES = {
    'default': {
        'ENGINE': 'djongo',
        'ENFORCE_SCHEMA': True,
        'NAME': 'earthquakes',  # 修改
        'HOST': '127.0.0.1',  # 修改
        'PORT': 27017,
    }
}
```
## 初始化数据库
> 需下载数据，等待时间较长

> 实测，在服务器上下载数据会被封IP，自行使用代理。在本地电脑上不会被封
```shell
cd /backend
python manage.py migrate
```
## 重启服务
```shell
supervisorctl restart uwsgi
# 退出容器
cd /
exit
```
