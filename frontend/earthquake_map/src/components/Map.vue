<template>
    <body>
        <div id='container'></div>
    </body>
</template>

<style scoped>
#container{
    /*地图(容器)显示大小*/
        width:100%;
        height:100%;
        position: absolute;
        top: 0px;  
        bottom: 0px;
        left: 0px;
        right: 0px;
}
</style>

<script>
export default{
    mounted(){
        this.initMap()
    },
    methods:{
        initMap() {
            //定义地图中心点坐标
            var center = new window.TMap.LatLng(39.984120, 116.307484)
            //定义map变量，调用 TMap.Map() 构造函数创建地图
            var map = new window.TMap.Map(document.getElementById('container'), {
                center: center,//设置地图中心点坐标
                zoom: 4,   //设置地图缩放级别
                pitch: 0,  //设置俯仰角
                rotation: 0    //设置地图旋转角度
            });
        },
        loadScript() {
            var script = document.createElement("script");
            script.type = "text/javascript";
            script.src = "https://map.qq.com/api/gljs?v=1.exp&key=EY7BZ-UOOWQ-52L5P-GDJII-5VKL7-HOFMW&callback=init";
            document.body.appendChild(script);
        }
    }
}
</script>
