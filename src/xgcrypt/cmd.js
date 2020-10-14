var spawn = require('child_process').spawn;

free = spawn('node', ['cp.js']);

// 捕获标准输出并将其打印到控制台 
free.stdout.on('data', function (data) { 
  console.log('standard output:\n' + data); 
});
// 捕获标准错误输出并将其打印到控制台 
free.stderr.on('data', function (data) { 
  console.log('standard error output:\n' + data); 
});
// 注册子进程关闭事件 
free.on('exit', function (code, signal) { 
  console.log('child process eixt ,exit:' + code); 
});





// var exec = require('child_process').exec;
// var cmd = 'node cp.js ';

// exec(cmd, function(error, stdout, stderr) {
//   // 获取命令执行的输出
//   console.log(error,stdout,stderr)
// });


// var execSync = require('child_process').execSync;;
//  //var cmd = 'node cp.js';
// // var cmd = 'python py.py';
// var cmd =execSync('npm -v')


// var spawn = require('child_process').spawn;
// var child = spawn('node', [
//  'cp.js'
//   //'-o', 'builds/pdf/book.pdf'
// ]);

// child.stdout.on('data', function(chunk) {
//   // output will be here in chunks
// });

// // or if you want to send output elsewhere
// //child.stdout.pipe(dest);

// var execFile = require('child_process').execFile;
// execFile(file, args, options, function(error, stdout, stderr) {
//   // command output is in stdout
// });