

import axios from 'axios'
const BASE = '/api';

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
export const reqAudioLogin = (formData,value)=> axios.post(BASE + '/public/',formData,{params:value});
export const reqGetAudioLogin = ()=> axios.get(BASE + '/public/');

//获取列表
export const reqAudioList = (formData)=> axios.get(BASE + '/public/index.php?list=1',formData);
