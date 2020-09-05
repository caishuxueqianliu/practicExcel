<template>
  <div class="about">
<hr>
<div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">输入</span>
  </div>
  <textarea v-model="textInput" class="form-control" aria-label="With textarea"></textarea>
</div>

<div class="btn"> 
<button type="button"  class="btn  btn-primary" @click="decode()">urlcode解码</button>
<button type="button" class="btn btn-primary" @click="encode()">urlcode编码</button>
<button type="button" class="btn btn-primary" @click="enaes()">aes加密</button>
<button type="button" class="btn btn-primary" @click="deaes()" >aes解密</button>
<button type="button" class="btn btn-primary" @click="formatJson()">Json格式化</button>
</div>

<div class="btn ">
<button  type="button"  class=" btn btn1 btn-success" @click="replacex()">输出转输入</button>
</div>




<div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">输出</span>
  </div>
  <textarea  v-model="this.textOutput" class="form-control" aria-label="With textarea"></textarea>
</div>
  </div>
</template>

<script>
import crypt from '../crypt.js'
import Prpcrypt from '../Prpcrypt.js'
export default {
  name: 'About',
  data(){
     return{
         textInput:"",
         textOutput:""
     }
  },
  methods:{
  replacex(){

      this.textInput=this.textOutput;
        
    },
  decode(){
  // console.log(this.textInput)
  //this.textOutput=decodeURIComponent(this.textInput);
   this.textOutput=decodeURIComponent(this.textInput);
  },
  encode(){
    //this.textOutput=decodeURIComponent(this.textInput);
  //  console.log(this.textInput)
    this.textOutput=encodeURIComponent(this.textInput);
  },
  deaes(){
 this.textOutput=crypt.decrypt(this.textInput);
  },
  enaes(){
 this.textOutput=crypt.encrypt(this.textInput);
  },
  formatJson(){
    var json = this.textInput;
json = JSON.parse(json);//将json字符串格式化为json对象
JSON.stringify(json, null, "\t")

   this.textOutput=JSON.stringify(json, null, "\t")
  }
 
}

}
</script>

<style lang="less">

hr{
opacity: 0;
}
.input-group-prepend{
	height: 200px;
}
.btn{
  display: flex;
  text-decoration:row;
  justify-content:flex-start;
.btn-primary{
    padding: 10px;
    margin-left: 10px ;
  }
.btn-success{
    padding: 10px;
    margin-left: 10px;
  
}
}
</style>