<template>
  <el-container>
    <el-header></el-header>
    <el-main>
      <Map ref="map" />
    </el-main>
    <el-footer style="bottom: 10%; position: absolute; width: 70%; left: 30%">
      <Search v-on:searchBotton="searchBotton" ref="search"/>
    </el-footer>
  </el-container>
</template>

<script>
import Map from './components/Map.vue'
import Search from './components/Search.vue'

export default{
  name: 'App',
  components: {
    Map,
    Search,
  },

  methods:{
    searchBotton(earthquakeList, length){
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
