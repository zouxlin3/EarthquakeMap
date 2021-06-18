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
        z-index: -1;
}
</style>

<script>
export default{
    data(){
        return{
            url: require("../assets/marker.png")
        }
    },
    mounted(){
        this.initMap()
        console.log('initialize map succeed.')
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

            var markerLayer = new window.TMap.MultiMarker({
                map: map,  //指定地图容器
                //样式定义
                styles: {
                    "earthquake": new window.TMap.MarkerStyle({ 
                        "width": 24,  // 点标记样式宽度（像素）
                        "height": 24, // 点标记样式高度（像素）
                        "src": this.require,  //图片路径
                        //焦点在图片中的像素位置，一般大头针类似形式的图片以针尖位置做为焦点，圆形点以圆心位置为焦点
                        "anchor": { x: 12, y: 12 }  
                    }) 
                },
                //点标记数据数组
                geometries: []
            });
        },

        addPoint(earthquakeList, length) {
            console.log('adding Points...')
            for (var i = 0; i < length; i++){
                this.markerLayer.add([
                    {
                        'id': earthquakeList[i]['id'],
                        'styleId': 'earthquake',
                        "position": new window.TMap.LatLng(earthquakeList[i]['latitude'], earthquakeList[i]['longitude']),
                    }
                ])
                console.log('add Point ', i)
            }
        },
    }
}
</script>
