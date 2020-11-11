

import axios from 'axios'


// export const reqGet = ()=>  axios.get(BASE+'/get');

// export const reqGetUsers = ()=>  axios.get(BASE+'/getUsers');

// export const reqPostUsers = (values)=>  axios.post(BASE+'/postUsers',{values});
export const reqPostInfo = (url,value)=> axios.post(url,null,{params:value});

export const reqGetSeverList = (url,value)=>  axios.get(url+'?x='+value.x+"&m="+value.m);

export const reqPostRegister = (url,value)=> axios.post(url,null,{params:value});

export const reqPostLogin = (url,value)=> axios.post(url,null,{params:value});

 //export const ceshi = (value)=>  axios.post('http://iosaudit.xuegaogame.com/public/index.php?list=');

// { ‘content-type’: ’application/x-www-form-urlencoded’ }
// {'Content-Type': 'application/json'}


//中转服相关请求
//登陆
export const reqAudioLogin = (url,formData,value)=> axios.post(url,formData,{params:value});

//获取列表
export const reqAudioList = (url,formData)=> axios.post(url,formData);
