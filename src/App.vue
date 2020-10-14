


<template>
  <div id="app">

    <div id="nav">

    <!--   <router-link to="/">Home</router-link> |
      <router-link  to="/about">About</router-link> -->
          <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" >{{time}}</a>
  <div class="navdiv">
   <router-link to="/home" class="navbar-brand" >Home</router-link>
   <router-link to="/Config" class="navbar-brand" v-show="isConf">Config</router-link>
   <router-link to="/kits" class="navbar-brand" >Tools</router-link>
      <router-link to="/xgCrypt" class="navbar-brand" >XgCrypt</router-link>
 </div>
</nav>
    </div>
    <router-view/>
  </div>
</template>
<script >
  export default{
    data(){
      return{
         time:parseInt(Date.now()/1000),
         isConf:this.$store.state.isConf
       }
    },
    created(){

    },
    mounted(){
        this.getTime();
    },
    methods:{
       getTime(){
        setInterval(()=>{
        this.time= parseInt(Date.now()/1000) 
       },1000)
      }
    },
    components:{

    },
    watch:{

    },
    computed:{
     
     
    }
}
  

</script>
<style>

#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: white;}

#nav a.router-link-exact-active {
  color: white;
}
.navdiv{
  display: flex;
  width: 100%;
  text-decoration: row;
  justify-content: flex-end;
  text-align: right;
}
</style>
