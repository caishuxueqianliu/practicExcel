const fs = require('fs')
const path = require('path')
function rmdirPromise(filePath) {
  return new Promise((resolve, reject) => {

 fs.exists(filePath, function(exists) {

if(exists){
    fs.stat(filePath, function (err, stat) {
      if (err) reject(err)
      if (stat.isFile()) {
        fs.unlink(filePath, function (err) {
          if (err) reject(err)
          resolve()
        })
      } else {
        fs.readdir(filePath, function (err, dirs) {
          if (err) reject(err)
          dirs = dirs.map(dir => path.join(filePath, dir))
          dirs = dirs.map(dir => rmdirPromise(dir))
          Promise.all(dirs).then(() => {
            fs.rmdir(filePath, resolve)
          })
        })
      }
    })
    }
    // else{
    //   console.log(filePath+'不存在')
    // }

})

  })
}



//拷贝
var copy=function(src,dst){
    let paths = fs.readdirSync(src); //同步读取当前目录
    paths.forEach(function(path){
        var _src=src+'/'+path;
        var _dst=dst+'/'+path;
        fs.stat(_src,function(err,stats){  //stats  该对象 包含文件属性
            if(err)throw err;
            if(stats.isFile()){ //如果是个文件则拷贝 
                let  readable=fs.createReadStream(_src);//创建读取流
                let  writable=fs.createWriteStream(_dst);//创建写入流
                readable.pipe(writable);
            }else if(stats.isDirectory()){ //是目录则 递归 
                checkDirectory(_src,_dst,copy);
               // console.log(path+'拷贝成功');
            }
        });
    });
}
//检查是否文件夹
var checkDirectory=function(src,dst,callback){
    fs.access(dst, fs.constants.F_OK, (err) => {
        if(err){
            fs.mkdirSync(dst);
            callback(src,dst);
        }else{
            callback(src,dst);

        }
     
      });
};


//引入readline模块
const readline = require('readline');

//创建readline接口实例
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// question方法

var renshen;
var gongcheng;

 rl.question('请输入工程目录: ', function(answer){
    console.log(answer.toString());
     gongcheng=answer.toString();
     gongcheng=gongcheng.replace(/\s*/g,"");

 
var delDir=['/cocosstudio/res/image/review/','/cocosstudio/ccs/review/','/ccs/review/','/src/RW/view/review/','/res/image/review/'];

for (var i = 0; i <= delDir.length-1; i++) {

//delDirItem[i]=(gongcheng+delDir[i]).toString();
//console.log(delDirItem);
// rmdirPromise(delDirItem).then(() => {
//   console.log(delDirItem+'删除成功');
//   //checkDirectory(renshen,gongcheng,copy);
// })
 
// console.log((gongcheng+delDir[i]).toString())


rmdirPromise((gongcheng+delDir[i]).toString()).then(() => {
 // console.log('指定目录删除成功');
})

 }  

console.log('拷贝前指定目录删除成功');
rl.question('请输入人审目录: ', function(answer){
     console.log(answer.toString());
    renshen=answer.toString();
    renshen=renshen.replace(/\s*/g,"");

 
 checkDirectory(renshen,gongcheng,copy);
console.log('拷贝成功');
rl.close();

});

});








