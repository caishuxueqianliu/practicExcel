<template>
    <div id="XgCrypt">
        <hr>
        <hr>

        <div class="input-group input-group1 mb-3">
            <input type="text" v-model="directKey" class="form-control" placeholder="directKey" aria-label="directKey" aria-describedby="button-addon2">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button"  @click="uploadDirectKey()">设置directKey</button>
            </div>
        </div>

<!--        <div class="input-group mb-3">-->
<!--            <input type="text" class="form-control" v-model="fileOrDirPath" placeholder="fileOrDirPath" aria-label="fileOrDirPath" aria-describedby="button-addon2">-->
<!--            <div class="input-group-append">-->
<!--                <button class="btn btn-outline-secondary" type="button" @click="getFileName()">生成加密路径名</button>-->
<!--            </div>-->
<!--        </div>-->
        <div class="getName">

        <el-autocomplete
                class="input-group input-group1 mb-3 "
                popper-class="my-autocomplete"
                v-model="state"
                :fetch-suggestions="querySearch"
                placeholder="请输入路径"
                @select="handleSelect">
            <i
                    class="el-icon-edit el-input__icon"
                    slot="suffix"
                    @click="handleIconClick">
            </i>
            <template slot-scope="{ item }">
                <div class="name">{{ item.value }}</div>
                <span class="addr">{{ item.address }}</span>
            </template>
        </el-autocomplete>


                <button class="btn btn-outline-secondary"  @click="getFileName()" >生成加密路径名</button>


        </div>
        <div class="txtOut">
        <div class="xx">是否为多层目录:{{isDir}}</div>
        <div class="xx">文件名: {{FileName}}</div>
        <div class="xx">目录名: {{DirPath}}</div>
        </div>


    </div>
</template>

<script>
import md5json from "../xgcrypt/extra/dfs/md5dfs.json"
    export default{
        name:"XgCrypt",
        data(){
            return{
                directKey:"",
                fileOrDirPath:"",
                isDir:"",
                FileName:"",
                DirPath:"",
                restaurants: [],
                state: '',
                searchValue:''
            }
        },
        created(){

        },
        mounted(){
            this.restaurants = this.loadAll();
        },
        methods:{
            querySearch(queryString, cb) {
                var restaurants = this.restaurants;
                var results = queryString ? restaurants.filter(this.createFilter(queryString)) : restaurants;
                // 调用 callback 返回建议列表的数据
                cb(results);
            },
            createFilter(queryString) {
               // console.log("queryString="+queryString)

                return (restaurant) => {
                   // console.log("restaurant="+JSON.stringify(restaurant))
                   //  return (restaurant.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                    return (restaurant.value.toLowerCase().match(queryString.toLowerCase()));
                    //return restaurant
                };



            },
            loadAll() {
                var arr=[]

                    for(var i in md5json){
                       // console.log({ "value": i} )

                      arr.push({ "value": md5json[i]})
                        //console.log(arr)
                      //  return [ { "value": i}   ];

                }

                   return arr
                      //  return [ {"value":Object.values(md5json)}]


                },
            handleSelect(item) {
                console.log(item);
                this.fileOrDirPath=item.value.split('.')[0].toString()
                console.log(this.fileOrDirPath);
            },
            handleIconClick(ev) {
                console.log(ev);
            },
            uploadDirectKey(){
                console.log(this.directKey)
            },
            getFileName(){
            var str= this.fileOrDirPath.split('/')
                //console.log(str)
                if(str.length>1){
                    this.isDir=true;
                    this.FileName=this.$md5(str[str.length-1])
                    //console.log(str[str.length-1])
                  //  console.log(this.FileName)
                    if(this.directKey!=""){
                        this.FileName=this.$md5(this.FileName+this.directKey)
                      // console.log(this.FileName)
                    }
                    else if(this.directKey==""){
                         this.FileName=this.$md5(this.FileName)
                        
                    }

                    str.pop();
                   // console.log(str.join("/"))
                    //console.log(this.FileName)
                    this.DirPath=this.$md5(str.join("/"))
                  //console.log(this.DirPath)
                    if(this.directKey!=""){
                        this.DirPath=this.$md5(this.DirPath+this.directKey)
                      // console.log(this.DirPath)
                    }
                       else if(this.directKey==""){
                         this.FileName=this.$md5(this.FileName)
                        
                    }

                }
                else if(str.length==1){
                    this.isDir=false;
                    this.FileName=this.$md5(str[0])
                    if(this.directKey!=""){
                        this.FileName=this.$md5(this.FileName+this.directKey)
                    }
                       else if(this.directKey==""){
                         this.FileName=this.$md5(this.FileName)
                        
                    }
                    //console.log(this.FileName)
                    this.DirPath="null"
                }
            },
        getmd5dfs(){
         //  console.log(md5json)
            for (var i in md5json){
                //console.log(i)//值
                //console.log(md5json[i])//键
               // this.searchValue=i
            }

            //console.log(Object.values(md5json))
            // console.log(Object.keys(md5json))
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





<style lang="less">
.getName{
    display: flex;
    flex-direction: row;

}
#XgCrypt{
   // width: 500px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.input-group1{
    //margin-top: 20px;
    width: 600px;
    height: 24px;
}
.getName{
    margin: 20px;
}
.txtOut{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
   margin-top: 24px;
 .xx{
     margin-top: 20px;
 }

}

</style>
