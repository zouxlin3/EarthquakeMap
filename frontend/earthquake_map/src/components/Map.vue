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
            url: require("../assets/marker.png"),
            map: '',
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
            this.map = new window.TMap.Map(document.getElementById('container'), {
                center: center,//设置地图中心点坐标
                zoom: 4,   //设置地图缩放级别
                pitch: 0,  //设置俯仰角
                rotation: 0    //设置地图旋转角度
            });
        },

        addPoint(earthquakeList, length) {
            var markerLayer = new window.TMap.MultiMarker({
                map: this.map,  //指定地图容器
                geometries: [],
                styles: {
                    "earthquake": new window.TMap.MarkerStyle({
                        "width": 20,
                        "height": 20,
                        "src": this.url,
                        "anchor": { x: 10, y: 10 },
                        "opacity": 0.5
                    })
                }
            });

            console.log('adding Points...')
            for (var i = 0; i < length; i++){
                markerLayer.add([
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
