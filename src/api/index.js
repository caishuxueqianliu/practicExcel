

import axios from 'axios'


// export const reqGet = ()=>  axios.get(BASE+'/get');

// export const reqGetUsers = ()=>  axios.get(BASE+'/getUsers');

// export const reqPostUsers = (values)=>  axios.post(BASE+'/postUsers',{values});
export const reqPostInfo = (url,value)=> axios.post(url,null,{params:value});

export const reqGetSeverList = (url,value)=>  axios.get(url+'?x='+value.x+"&m="+value.m);

export const reqPostRegister = (url,value)=> axios.post(url,null,{params:value});

export const reqPostLogin = (url,value)=> axios.post(url,null,{params:value});
// export const reqPostUsers = (values)=>  axios.post(BASE+'/postUsers',{values});

// { ‘content-type’: ’application/x-www-form-urlencoded’ }
// {'Content-Type': 'application/json'}