# EarthquakeMap
# 简介
# 实现功能
# 部署方法
## 运行docker容器
```shell
docker pull zouxlin3/earthquake_map
docker run --name earthquake_map -d -p 8000:8000 zouxlin3/earthquake_map
# -p 主机端口:容器端口
```
## 安装数据库
> 在容器里安装
```shell
# 进入容器
docker exec -it earthquake_map bash

# 下载mongodb
cd /
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian10-4.4.6.tgz
tar -zxvf mongodb-linux-x86_64-debian10-4.4.6.tgz
mv mongodb-linux-x86_64-debian10-4.4.6 /mongodb

# 删掉下载的压缩包
rm -f mongodb-linux-x86_64-debian10-4.4.6.tgz

# 配置mongodb
mkdir -p /var/lib/mongo
mkdir -p /var/log/mongodb
/mongodb/bin/mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork
/mongodb/bin/mongo

# 进入了mongodb shell
use earthquakes
exit
```
## 启动服务
```shell
# web server
nginx start

# 初始化数据库
cd /backend
python manage.py migrate
```
使用`IP:8000`地址访问
