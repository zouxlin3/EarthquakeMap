<template>
    <el-card class="box-class">
        <li v-for="earthquake in earthquakeList" :key="earthquake">
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
