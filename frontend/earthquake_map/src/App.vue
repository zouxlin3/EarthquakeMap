<template>
  <el-container>
    <el-header></el-header>
    <el-main>
      <Map />
    </el-main>
    <el-footer style="bottom: 100px; position: absolute; width: 70%; left: 30%">
      <Search />
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
    searchBotton(earthquakeList){
      this.$refs.Map.addPoint(earthquakeList)
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
