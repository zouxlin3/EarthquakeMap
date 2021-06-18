<template>
    <el-card class="box-card">
        <el-row type="flex">
            <el-col :span="18">
                <div class="block">
                    <p>数据范围：{{ dateRange }}</p>
                    <el-date-picker
                    v-model="value"
                    format="YYYY-MM-DD"
                    type="daterange"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期"
                    :default-time="defaultTime"
                    ></el-date-picker>
                </div>
            </el-col>
            <el-col :span="6">
                <el-button type="primary" icon="el-icon-search" @click="searchBotton">搜索</el-button> 
            </el-col>
        </el-row>
    </el-card>
</template>

<script>
import axios from 'axios'

  export default {
    data() {
      return {
        defaultTime: [
          new Date(Date.UTC(2000, 1, 1, 0, 0, 0)),
          new Date(Date.UTC(2000, 2, 1, 23, 59, 59))
        ], // '00:00:00', '23:59:59'
        dateRange: '',
        earthquakeList: '',
        value: '',
        length: '',
      };
    },
    mounted(){
        this.getDateRange()
        console.log('get date range succeed.')
    },
    methods: {
        getDateRange(){
            axios
                .get('http://localhost:5000/api/date_range')
                .then(response => (
                    this.dateRange = response.data
                ))
        },

        getEarthquakeList(daterange){
            axios
                .get('http://localhost:5000/api/list?start='+daterange[0].toISOString()+'&end='+daterange[1].toISOString())
                .then(response => (
                    this.earthquakeList = response.data['list'],
                    this.length = response.data['length']
                ))
        },

        searchBotton(){
            this.getEarthquakeList(this.value)
            this.$emit('searchBotton', [this.earthquakeList, this.length])
        }
    }
  };
</script>
