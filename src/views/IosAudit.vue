<template>
    <div id="IosAudit">
 <button class="login" @click="login()">login</button>
        <button class="login" @click="getInfo()">login</button>
    </div>
</template>

<script>
import {reqAudioLogin,reqAudioList} from "../api"
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
                const formData=new FormData();
                 formData.append('password',"xuegao666");
                // const formData={
                //     password:"xuegao666"
                // }
                reqAudioLogin("/api/public",formData).then(res=>{
                    console.log(res)
                })
            },
            getInfo(){
                reqAudioList("/api/public/index.php?list").then(res=>{
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
