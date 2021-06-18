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
                geometries: []
            });

            console.log('adding Points...')
            var size = 8
            var pointSize = 0
            for (var i = 0; i < length; i++){
                pointSize = Math.round(size * earthquakeList[i]['mag']) // 根据震级动态大小

                markerLayer.setStyles({
                    "earthquake": new window.TMap.MarkerStyle({
                        "width": pointSize,
                        "height": pointSize,
                        "src": this.url,
                        "anchor": { x: pointSize/2, y: pointSize/2 },
                        "opacity": 0.5
                    })
                })

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
