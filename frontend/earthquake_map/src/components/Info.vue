<template>
    <el-card shadow="hover" :body-style="{ padding: '0px' }">
        <el-row type="flex" align="middle" justify="center">
            <el-col :span="6">
                <b>{{ earthquake['mag'] }}</b>
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
    props:['earthquake']
}
</script>

<style scoped>
.el-card:hover{
    cursor: pointer;
}
</style>
