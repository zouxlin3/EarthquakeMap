<template>
    <el-card class="box-class" :body-style="{ padding: '0px' }">
            <li v-for="earthquake in earthquakeList" :key="earthquake" style="list-style: None">
                <Info :earthquake="earthquake" v-on:focus="focus" />
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

    props:['earthquakeList'],

    data(){
        return{
            last_click_id: ''
        }
    },

    methods:{
        focus(id){
            if (this.last_click_id) {
                document.getElementById(this.last_click_id).style.borderColor = '#EBEEF5'
            }
            this.last_click_id = id
            this.$emit('focus', id)
        }
    }
}
</script>
