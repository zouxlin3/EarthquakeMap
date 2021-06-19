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
            markerUrl: require("../assets/marker.png"),
            focusrUrl: require("../assets/focus.png"),
            map: '',
            zoom: 4,
            center: new window.TMap.LatLng(39.984120, 116.307484),
            markerLayer: '',
            focusLayer: '',
        }
    },
    mounted(){
        this.initMap(this.center, this.zoom)
        console.log('initialize map succeed.')
    },
    methods:{
        initMap(center, zoom) {
            this.map = new window.TMap.Map(document.getElementById('container'), {
                center: center,//设置地图中心点坐标
                zoom: zoom,   //设置地图缩放级别
                pitch: 0,  //设置俯仰角
                rotation: 0    //设置地图旋转角度
            });
        },

        addPoint(earthquakeList, length) {
            if(this.markerLayer){
                this.markerLayer.setMap(null)
            }

            var markerLayer = new window.TMap.MultiMarker({
                map: this.map,  //指定地图容器
                geometries: [],
                styles: {
                    "earthquake": new window.TMap.MarkerStyle({
                        "width": 20,
                        "height": 20,
                        "src": this.markerUrl,
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

            this.markerLayer = markerLayer
        },

        focusPoint(id){
            if(this.focusLayer){
                this.focusLayer.setMap(null)
            }

            var pointGeo = this.markerLayer.getGeometryById(id)
            this.map.setCenter(pointGeo.position)

            var focusLayer = new window.TMap.MultiMarker({
                map: this.map,
                geometries: [],
                styles: {
                    "focus": new window.TMap.MarkerStyle({
                        "width": 20,
                        "height": 20,
                        "src": this.focusrUrl,
                        "anchor": { x: 10, y: 10 },
                        "opacity": 1
                    })
                }
            })

            focusLayer.add([
                {
                    'id': id,
                    'styleId': "focus",
                    'position': pointGeo.position,
                }
            ])

            this.focusLayer = focusLayer
        }
    }
}
</script>
