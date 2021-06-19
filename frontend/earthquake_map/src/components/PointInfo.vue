<template>
    <el-card class="box-card" id="pointInfo">
        <template #header>
            <div class="card-header">
                <el-row type="flex" align="middle" justify="space-between">
                    <span style="font-size: 24px"><b>震级: &nbsp; </b>{{ earthquake['mag'] }}</span>
                    <el-button class="button" type="danger" plain @click="close">关闭</el-button>
                </el-row>

            </div>
        </template>
        <el-row type="flex" align="middle">
            <el-col :span="24">
                <p style="text-align: left"><b>坐标: &nbsp; </b>{{ earthquake['latitude'] }},{{ earthquake['longitude'] }}</p>
                <p style="text-align: left"><b>时间: &nbsp; </b>{{ earthquake['time'].slice(0,10)+' '+earthquake['time'].slice(11,19) }}</p>
            </el-col>
        </el-row>
    </el-card>
</template>

<script>
import axios from 'axios'

export default {
    data(){
        return{
            earthquake: {
                'time': '0000-00-00T00:00:00Z'
            },
        }
    },
    methods:{
        close(){
            document.getElementById("pointInfo").style.display = "none"
        },

        show(){
            document.getElementById("pointInfo").style.display = "block"
        },

        getById(id){
            axios
                .get('http://localhost:5000/api/get_by_id?id='+id)
                .then(response => (
                    this.earthquake = response.data,
                    this.show()
                ))
        }
    }
}
</script>

<style scoped>
#pointInfo{
    display: none;
}
</style>
