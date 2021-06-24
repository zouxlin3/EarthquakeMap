<template>
  <el-container>
    <el-header style="top: 5%; position: absolute; width: 600px; right: 7%">
      <Search v-on:searchBotton="searchBotton" ref="search"/>
    </el-header>
    <el-main>
      <Map ref="map" v-on:focusList="focusList" />
    </el-main>
    <el-aside style="top: 5%; position: absolute; left: 2%; bottom: 5%; width: 400px">
      <List :earthquakeList="earthquakeList" v-on:focus="focus" v-on:cancel="cancel" ref="list" />
    </el-aside>
    <el-footer style="position: absolute; right: 2%; bottom: 20%; width: 320px">
      <PointInfo ref="pointInfo" />
    </el-footer>
  </el-container>
</template>

<script>
import Map from './components/Map.vue'
import Search from './components/Search.vue'
import List from './components/List.vue'
import PointInfo from './components/PointInfo.vue'

export default{
  name: 'App',
  components: {
    Map,
    Search,
    List,
    PointInfo,
  },

  data(){
    return{
      earthquakeList: '',
    }
  },

  methods:{
    searchBotton(earthquakeList, length){
      this.earthquakeList = earthquakeList
      this.$refs.map.addPoint(earthquakeList, length)
      this.$refs.pointInfo.close()
    },
    focus(id){
      this.$refs.map.focusPoint(id)
      this.$refs.pointInfo.close()
    },
    cancel(){
      this.$refs.map.cancelFocus()
    },
    focusList(id){
      this.$refs.list.focus(id)
      this.$refs.pointInfo.getById(id)
    },
  }
};


</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
};
</style>
