<template>

<div>
<!--     <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="#">Navbar</a>

</nav> -->

<main role="main">

  <!-- Main jumbotron for a primary marketing message or call to action -->
  <div class="jumbotron">
    <div class="container">

<div class="input-group mb-3">

  <div class="input-group-prepend">
    <span class="input-group-text" v-show="isShow" id="inputGroupFileAddon01" @click='start()'>Start</span>
  </div>
  <div class="custom-file">
    <input type="file" name='file' ref='file' @change='file()' class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
    <label class="custom-file-label" for="inputGroupFile01">{{confn}}</label>
  </div>
  
</div>



    </div>
  </div>

<div class="container">


    <hr>

  </div> 



  <div class='conf' v-for="(item,key,i) in conf" :key="i">
<div class="alert alert-success"  role="alert">
  {{key}}={{item}}
  </div>





</div>


</main>





  </div>
</template>
<script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script>
 import XLSX from 'xlsx'
export default {
  name: 'Home',
  data(){
return{
    confn:'Choose config.xlsx',
    conf:{},
    confk:[],
    confv:[],
    isShow:false
  
}
  
  },
  components: {
   
  },
   created(){

    },
   mounted(){

    },
    methods:{

  file(){
  
 if(this.$refs.file.files[0]){   
   this.isShow=true;
     }

this.confn= this.$refs.file.files[0].name;

  
                  var k=[1];
                  var v=[2];
                  var c={};   
           var f=this.$refs.file.files[0]
                var reader = new FileReader(); 
                  reader.readAsBinaryString(f);
               reader.onload = function(e) {
                    var data = e.target.result;
                        
               var   wb = XLSX.read(data, {
                            type: 'binary'
                     });
                    
                var seltext=wb.SheetNames[0]

                     var conf={};
 
                    var curSheet = wb.Sheets[seltext];
                    // 表格的表格范围，可用于判断表头是否数量是否正确
                    var fromTo = curSheet['!ref'];
                    fromTo = fromTo.split(":");

                    var startRow = fromTo[0].charCodeAt(0);
                    var startLine = parseInt(fromTo[0].charAt(1));
                    var endRow = fromTo[1].charCodeAt(0);
                    var endLine = parseInt(fromTo[1].substr(1));

                    for (var line = startLine; line < endLine; line++){
                        var key = null;
                        var keyrow = startRow;

                        for (var row = startRow; row < endRow; row++){
                            var cell = String.fromCharCode(row) + line;
                            var cellStr = curSheet[cell];

                            if (cellStr && cellStr.w && cellStr.w.length > 0) {
                                if(key  && row == keyrow+1){
                                 // console.log(cellStr)
                                    conf[key] = cellStr.w;
                                    break;
                                }else{
                                    key = cellStr.w;
                                    keyrow = row;
                                }
                            }
                        }
                    }

              

                var confv=[];
                   for (var i in conf){  
                  confv.push(conf[i]);

                  }
       
                k=Object.keys(conf);
                v=confv
                c=conf;
             //  reader.readAsBinaryString(f);
              
                } 
                setTimeout(()=>{this.confk=k,this.confv=v,this.conf=c}, 100)
     
             },
  start(){
       if(this.confv.length){
       
      this.$store.commit('setConf',this.conf);
      this.$store.commit('setIsConf',true);
    console.log(this.$store.state)

        this.$router.push('/config')      
             }
  
  }

    },
    watch:{
     
      },
    computed:{
    }
}
</script>

<style lang="less">
// #home {
//   display: flex;
//   flex-direction: column;
//   font-family: Avenir, Helvetica, Arial, sans-serif;
//   -webkit-font-smoothing: antialiased;
//   -moz-osx-font-smoothing: grayscale;
//   //text-align: center;
//   color: #2c3e50;
// }

   .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
body {
  padding-top: 5rem;
}
.starter-template {
  padding: 10rem 1.5rem;
  text-align: center;
}
#inputGroupFileAddon01{
  cursor: pointer;
}

.custom-file-input:lang(zh) ~ .custom-file-label::after {
  content: "浏览";
}
 
.custom-file-label::after {
  content: "浏览";

}
.input-group-text{
  height: 39px;
}
.jumbotron{
  height: 200px;

}
</style>


