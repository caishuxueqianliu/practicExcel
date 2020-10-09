<template>
  <div class="home">

<div class="jumbotron jumbotron1">
  
  <p class="lead">{{this.$store.state.conf.ChannelCode}}</p>
  <hr class="my-4">
<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <a class="nav-item nav-link active" @click="reqInfo()" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">访问配置中心</a>
    <a class="nav-item nav-link" @click="reqGetServer()" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">获取服务器</a>
    <a class="nav-item nav-link" @click="reqRegister()" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">注册及登陆</a>
      <a class="nav-item nav-link" id="nav-contact-tab" @click='ceshi()' data-toggle="tab" href="#nav-login" role="tab" aria-controls="nav-login" aria-selected="false">其他</a>
     
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
    <p>url:{{this.conf.LaunchAdd}}</p>
    <p>methods:post</p>
    <p>params:{{this.info}}</p>
    <p>params(明文):{{this.infom}}</p>
    <p>服务器返回:{{this.infod}}</p>
    <p>服务器返回(明文):{{this.infodm}}</p>
  </div>
  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
  <p>url:{{serverUrl}}</p>
    <p>methods:GET</p>
    <p>params:{{this.servercrypt}}</p>
    <p>params(明文):{{this.servermm}}</p>
    <p>服务器返回:{{this.servedm}}</p>
    <p>服务器返回(明文):{{this.served}}</p>
  </div>
  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
  <p>url:{{registerUrl}}</p>
    <p>methods:Post</p>
    <p>params:{{this.registerreq}}</p> 
    <p>服务器返回:{{this.registerres}}</p>
    <p>url:{{loginUrl}}</p>
    <p>methods:Post</p>
    <p>params:{{this.loginreq}}</p> 
    <p>服务器返回:{{this.loginres}}</p>

  </div>
    <div class="tab-pane fade" id="nav-login" role="tabpanel" aria-labelledby="nav-login-tab">
 

    </div>
      <div   class="tab-pane fade" id="nav-extend" role="tabpanel" aria-labelledby="nav-extend-tab"> </div>
</div>
 <!--  <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a> -->
</div>

  </div>
</template>

<script>

import {reqPostInfo,reqGetSeverList,reqPostRegister,reqPostLogin} from '../api'
import crypt from '../crypt.js'
 //const jsonp = require('jsonp');
export default{
data(){
	return{
    conf:this.$store.state.conf,
    info:{},
    infom:{"v":this.$store.state.conf.GameVersion,"id":this.$store.state.conf.Identifier},
    infod:{},
    infodm:{},

  
    serverm:this.$store.state.conf.Channel,
    servermm:{"x":this.$store.state.conf.Channel,"m":this.$store.state.conf.Channel},
    servercrypt:{},
    servedm:{},
    served:{},

    registerreq:{},
    registerres:{},
    loginreq:{},
    loginres:{},


	}
},
create(){

},
mounted(){

this.reqInfo();

},
methods:{

reqInfo(){

var cryptInfo=crypt.encrypt(JSON.stringify(this.infom));
//var encryptInfo=encodeURIComponent(JSON.stringify(cryptInfo))
var encryptInfo=cryptInfo;
// console.log(encryptInfo)
var md5Info=this.$md5(JSON.stringify(this.infom));
this.info={x:encryptInfo,m:md5Info};
reqPostInfo(this.conf.LaunchAdd,this.info).then(data=>{
this.infod=JSON.stringify(data.data.x);
var decry=crypt.decrypt((data.data.x))
this.infodm=decry;
var infomobj=JSON.parse(decry)
this.$store.commit('setInfo',infomobj);
});

},
reqGetServer(){

var p={x:encodeURIComponent((crypt.encrypt(this.serverm))),m:this.$md5(this.serverm)};
this.servercrypt=p;
// console.log(crypt.encrypt(this.serverm))
// console.log(encodeURIComponent((crypt.encrypt(this.serverm))))
console.log(this.$md5(this.serverm))
reqGetSeverList(this.serverUrl,p).then(data=>{

	//console.log(data.data)
this.servedm=data.data
this.served=crypt.decrypt(data.data.x)

})
},
reqRegister(){

   let usr = '';
   let pwd= '';
    for(let i =0;i<8;i++){
          usr += String.fromCharCode(Math.floor(Math.random()*26+65))
          pwd += String.fromCharCode(Math.floor(Math.random()*26+65))
    }
  this.loginreq={"u":usr,"p":pwd,"channelCode":this.$store.state.conf.ChannelCode}
  this.registerreq={"u":usr,"p":pwd,"channelCode":this.$store.state.conf.ChannelCode};
reqPostRegister(this.registerUrl,{"u":usr,"p":pwd,"channelCode":this.$store.state.conf.ChannelCode}).then(data=>{
	this.registerres=data.data;

})

setTimeout(()=>{
  reqPostLogin(this.loginUrl,{"u":usr,"p":pwd,"channelCode":this.$store.state.conf.ChannelCode}).then(data=>{
  this.loginres=data.data;
  //console.log(data.data)
})
},100)



},
ceshi(){
 
 //原生的实现方式
let script = document.createElement('script');

script.src = 'http://iosaudit.xuegaogame.com/public/index.php?list=';

document.body.appendChild(script);

console.log(script)

// jsonp('http://iosaudit.xuegaogame.com/public/index.php?list=',(res,cb)=>{

//   console.log(cb);
// });

// this.$jsonp('http://iosaudit.xuegaogame.com/public/index.php?list=').then(json=>{
//   console.log(123)
//    console.log(json)
  
// }).catch(err => {
//   console.log(456)
//           console.log(err)
         
//         })
  // if (err) {
  //   console.error(err);
  // } else {
  //   console.log(data);
  // }


     // var httpRequest = new XMLHttpRequest();//第一步：创建需要的对象
     // httpRequest.withCredentials=true;
     //    httpRequest.open('Get', 'http://iosaudit.xuegaogame.com/public/index.php?list', true); //第二步：打开连接
     //    httpRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");//设置请求头 注：post方式必须设置请求头（在建立连接后设置请求头）
     //    httpRequest.send("");//发送请求 将情头体写在send中
     //    /**
     //     * 获取数据后的处理程序
     //     */
     //    httpRequest.onreadystatechange = function () {//请求后的回调接口，可将请求成功后要执行的程序写在其中
     //        if (httpRequest.readyState == 4 && httpRequest.status == 200) {//验证请求是否发送成功
     //            var json = httpRequest.responseText;//获取到服务端返回的数据
     //            console.log(json);
     //           // createTable(table,json);
     //        }
     //    };
    








}

},
computed:{
serverUrl:function(){
	var xx=this.$store.state.info;
 return "http://"+xx.s+"/master/serverlist";
        },
 registerUrl:function(){
 var xx=this.$store.state.info;
 return "http://"+xx.l+"/user/register";
       }, 
loginUrl:function(){
	var xx=this.$store.state.info;
    return "http://"+xx.l+"/user/login";
       }

}

	}
</script>

<style lang="less">
.jumbotron1{
	height: 800px;

}
.jumbotron{
	width:100%;
	
}
.tab-content{
	text-align: left;
}
</style>

