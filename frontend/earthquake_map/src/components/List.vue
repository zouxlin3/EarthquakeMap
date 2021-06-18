<template>
    <el-card class="box-class" :body-style="{ padding: '0px' }">
            <li v-for="earthquake in earthquakeList" :key="earthquake" style="list-style: None">
                <Info :earthquake="earthquake" />
            </li> 
    </el-card>
</template>

<script>
import Info from './Info.vue'

export default {
    name: 'List',
    components: {
        Info
    },

    props:['earthquakeList']
}
</script>
