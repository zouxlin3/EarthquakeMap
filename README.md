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
## 创建数据库
```shell
# 进入容器
docker exec -it earthquake_map bash
/mongodb/bin/mongo
# 进入了mongodb shell
use earthquakes
exit
```
> 如果mongodb连接失败，先执行下面的命令
```shell
/mongodb/bin/mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork
```
## 初始化数据库
```
cd /backend
python manage.py migrate
# 退出容器
cd /
exit
```
使用`IP:8000`地址访问
