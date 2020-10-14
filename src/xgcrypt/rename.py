#!/usr/bin/python2.7
# -*- coding: utf-8 -*-  
# 解密加密资源

import os
import sys 
reload(sys)
import hashlib
def md5(filename,directkey):
      m = hashlib.md5()
      m.update(filename)
      m.hexdigest()

      mmm= m.hexdigest()+directkey
     # print mmm
      x= hashlib.md5()
      x.update(mmm)
      x.hexdigest()
      
      
      return x.hexdigest()

def rename(path,directkey):
    # i = 0
    '该文件夹下所有的文件（包括文件夹）'
    FileList = os.listdir(path)
    '遍历所有文件'
    for files in FileList:
        '原来的文件路径'
        oldDirPath = os.path.join(path, files)
        '如果是文件夹则递归调用'
        if os.path.isdir(oldDirPath):
            rename(oldDirPath)
        '文件名'
        fileName = os.path.splitext(files)[0]
        '文件扩展名'
        fileType = os.path.splitext(files)[1]
        '新的文件路径'
        newDirPath = os.path.join(path, md5(fileName,directkey)+ fileType)
        '重命名'
        os.rename(oldDirPath, newDirPath)
        # i += 1


#path = '/Users/admin/Documents/kit/kitsss/0ad13516123ecdb0830e67b34cf02773'

if __name__ == '__main__':
    #rename(sys.argv[1])
    rename(sys.argv[1],sys.argv[2])

# print sys.argv[1]
# print sys.argv[2]
# 方式二：
# import os
# path = 'C:\\Users\Administrator\Desktop\AssetScan\\vuln'
# files = os.listdir(path)
# for i, file in enumerate(files):
#     NewName = os.path.join(path, "AssetScan_"+file)
#     OldName = os.path.join(path, file)
#     os.rename(OldName, NewName)