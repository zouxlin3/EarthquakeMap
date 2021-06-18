<template>
    <el-card class="box-card">
        <el-row type="flex" justify="space-around">
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
                <el-row style="margin-bottom: 5px; margin-top: 9px">
                    <el-button type="primary" icon="el-icon-search" @click="getEarthquakeList" :loading="getBtnState">{{ this.getBotton }}</el-button>
                </el-row>
                <el-row>
                    <el-button type="primary" icon="el-icon-refresh-right" @click="update" :loading="updateBtnState">{{ this.updateBotton }}</el-button> 
                </el-row>
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
        getBotton: '搜索',
        getBtnState: false,
        updateBotton: '更新',
        updateBtnState: false,
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

        getEarthquakeList(){
            this.getBtnState = true
            this.getBotton = '加载中'

            var daterange = this.value
            axios
                .get('http://localhost:5000/api/list?start='+daterange[0].toISOString()+'&end='+daterange[1].toISOString())
                .then(response => (
                    this.earthquakeList = response.data['list'],
                    this.length = response.data['length'],

                    this.$emit('searchBotton', this.earthquakeList, this.length),

                    this.getBtnState = false,
                    this.getBotton = '搜索',
                    this.$notify({
                        message: '加载成功！',
                        duration: 2000,
                        position: 'bottom-right',
                        showClose: false,
                        type: 'success'
                    })
                ))
        },

        update(){
            this.updateBtnState = true
            this.updateBotton = '更新中'

            axios
                .get('http://localhost:5000/api/check_latest')
                .then(response => (
                    this.getDateRange(),
                    
                    this.updateBtnState = false,
                    this.updateBotton = '更新',
                    this.$notify({
                        message: '数据库更新成功！',
                        duration: 2000,
                        position: 'bottom-right',
                        showClose: false,
                        type: 'success'
                    })
                ))
        }
    }
  };
</script>
