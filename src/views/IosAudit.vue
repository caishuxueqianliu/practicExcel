<template>
    <div id="IosAudit">
 <button class="login" @click="login()">login</button>
  <button class="login" @click="login1()">login1</button>
   <button class="login" @click="login2()">login2</button>
        <button class="login" @click="getInfo()">getlist</button>
    </div>
</template>

<script>
import {reqAudioLogin,reqGetAudioLogin,reqAudioList} from "../api"
    export default {
        name: "IosAudit",
        data() {
            return {}
        },
        created() {

        },
        mounted() {

        },
        methods: {
            login(){
          

                reqGetAudioLogin().then(res=>{

                })
            },
            login1(){
                const formData=new FormData();
                 formData.append('password',"xuegao666");
                // const formData={
                //     password:"xuegao666"
                // }
                reqAudioLogin(formData).then(res=>{
                    console.log(res)
                })
            },
                 login2(){
               // const formData=new FormData();
               //   formData.append('password',"xuegao666"); 
                const formData={
                    password:"xuegao666"
                }
                reqAudioLogin(formData).then(res=>{
                    console.log(res)
                })
            },
            getInfo(){
                reqAudioList().then(res=>{
                    console.log(res)
                })
            }
        },
        components: {},
        watch: {},
        computed: {}
    }
</script>


<style lang="less" scoped>
    .login{
        margin-top: 200px;
    }
</style>
