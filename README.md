# EarthquakeMap
# 1 简介
在地图上展示过去十年的地震记录

后端使用`django`框架，通过`djongo`库连接`mongodb`数据库。前端使用`vue`开发，通过`axios`与后端连接，采用`ELement UI`库。

地图使用腾讯地图`Javascript API`，数据来自`USGS Earthquake Hazard Program`
# 2 实现功能
- 依据选择的时间段在地图上标记该时间段发生地震的位置
- 列出时间段内地震的详细信息
- 点击地图上的地震标记弹出详细信息
- 更新地震数据到最新一天
# 3 前端部署
## 3.1 上传网站
修改`/frontend/earthquake_map/src/components/`文件夹内的`PointInfo.vue`和`Search.vue`

将api地址改为自己服务器的地址，如果前后端均在本地运行则不需要改动

打包vue项目，上传`/dist`文件夹到服务器

## 3.2 nginx配置
安装`nginx`和`supervisor`

在`/etc/nginx/sites-available`文件夹新建配置文件`em_f_nginx.conf`(自行更改文件名)
> 如果没有`/etc/nginx/sites-available`和`/etc/nginx/sites-enabled`文件夹，自行新建，并在`/etc/nginx/nginx.conf`的`http`模块中加入`include /etc/nginx/sites-enabled/*;`

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
> 查看`/etc/supervisord.conf`的最后一行`include`的内容，修改配置文件后缀为`.conf`以及配置文件路径

输入以下内容
```
[program:nginx]
command = nginx -g "daemon off";
redirect_stderr=true
autostart=true
autorestart=true
stdout_logfile=/stdout
stdout_logfile_maxbytes=0
```
运行进程守护
```shell
supervisord -c /etc/supervisord.conf
```
# 4 后端部署
自行安装mongodb数据库，设置允许远程连接，并创建名为`earthquakes`的`database`
## 4.1 运行docker容器
```shell
docker pull zouxlin3/earthquake_map_api
docker run --name earthquake_map_api -d -p 5000:5000 zouxlin3/earthquake_map_api
# -p 主机端口:容器端口
```
## 4.2 连接数据库
```shell
# 进入容器
docker exec -it earthquake_map_api bash
```
修改`/backend/django_vue/settings.py`文件的数据库选项，改为自己的配置
```
DATABASES = {
    'default': {
        'ENGINE': 'djongo',
        'ENFORCE_SCHEMA': True,
        'NAME': 'earthquakes',  # 修改
        'HOST': '127.0.0.1',  # 修改
        'PORT': 27017,
        'USER': 'db-user',  # 修改
        'PASSWORD': 'password',  # 修改
    }
}
> 由于`pymongo`的默认配置使用`localhost`，如果是远程数据库需要修改其配置

修改配置文件
```shell
vim /usr/local/lib/python3.8/site-packages/pymongo/mongo_client.py
```
```
HOST = "远程数据库IP"
```
## 4.3 初始化数据库
> 需下载数据，等待时间较长

> 实测，在服务器上下载数据会被封IP，自行使用代理。在本地电脑上不会被封
```shell
python manage.py migrate
```
## 4.4 django跨域设置
修改`/backend/django_vue/settings.py`文件的`ALLOWED_HOSTS`选项
```
ALLOWED_HOSTS = ['后端IP']
```
## 4.5 重启服务
```shell
supervisorctl restart uwsgi
# 退出容器
cd /
exit
```
# 5 完成部署
使用`IP:8000`地址访问
