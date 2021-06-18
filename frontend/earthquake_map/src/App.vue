<template>
  <el-container>
    <el-header style="top: 5%; position: absolute; width: 600px; right: 7%">
      <Search v-on:searchBotton="searchBotton" ref="search"/>
    </el-header>
    <el-main>
      <Map ref="map" />
    </el-main>
    <el-aside style="top: 5%; position: absolute; left: 2%; bottom: 5%; width: 400px">
      <List :earthquakeList="earthquakeList" />
    </el-aside>
    <el-footer></el-footer>
  </el-container>
</template>

<script>
import Map from './components/Map.vue'
import Search from './components/Search.vue'
import List from './components/List.vue'

export default{
  name: 'App',
  components: {
    Map,
    Search,
    List,
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
    }
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
