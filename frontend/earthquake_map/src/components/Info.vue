<template>
    <el-card shadow="hover" :body-style="{ padding: '0px' }" :id="earthquake['id']" @click.enter="focus" style="border-radius: 0; border-width: 2px">
        <el-row type="flex" align="middle" justify="center">
            <el-col :span="6">
                <b style="font-size: 24px">{{ earthquake['mag'] }}</b>
            </el-col>
            <el-col :span="18">
                <p>({{ earthquake['latitude'] }},{{ earthquake['longitude'] }})</p>
                <p>{{ earthquake['time'].slice(0,10)+' '+earthquake['time'].slice(11,19) }}</p>
            </el-col>
        </el-row>
    </el-card>
</template>

<script>
export default {
    props:['earthquake'],
    methods:{
        focus(){
            this.$emit('focus', this.earthquake['id'])
        }
    }
}
</script>

<style scoped>
.el-card:hover{
    cursor: pointer;
}
</style>
