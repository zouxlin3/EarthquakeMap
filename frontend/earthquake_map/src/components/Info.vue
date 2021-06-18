<template>
    <el-card shadow="hover">
        <el-row type="flex" align="middle">
            <el-col :span="6">
                <p>{{ earthquake['mag'] }}</p>
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
