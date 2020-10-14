#!/usr/bin/python2.7
# -*- coding: utf-8 -*-  
# 解密加密资源


import os
import json
import shutil
import hashlib

import sys 
reload(sys)
sys.setdefaultencoding('utf8')


#############################################################################################################
# 
BIN_XXTEA = 'extra/xxtea'
# 
XXTEA_SIGN = 'icegame'
# 
XXTEA_KEY = 'iloveuxuegaogame'
# 不加密的文件后缀名
XXTEA_NO_EXTS = ['.mp3', '.mp4', '.ttf', '.ExportJson'] #205M
# 
MD5DFS_JSON_FILE = 'extra/dfs/md5dfs.json'
# 加密目录
ENCODE_DIR = 'data'
# 二次加密头
HEADER_FLAG = '+sign-'
#
SIGN_KEY_DIC = {}
#
REMOVE_SIGN_KEY_FILE = False

#############################################################################################################
def full_dirname(dirname):
    '''
    获取文件夹命全路径
    '''
    if os.path.isdir(dirname):
        if dirname.endswith('/'):
            return dirname
        return dirname + '/'


def check_except(rel_file_path, execpts):
    if not rel_file_path.startswith(ENCODE_DIR):
        return False
    if execpts is not None:
        for execpt in execpts:
            if rel_file_path.startswith(execpt):
                return True
    return False


def check_xxtea_by_ext(rel_file_path):
    ext_name = os.path.splitext(rel_file_path)[1]
    if ext_name in XXTEA_NO_EXTS:
        return False
    return True


#############################################################################################################

def encrypt_signkey(str):
    char_list = []
    for i in str:
        char_list.append(chr(ord(i) ^ 250))
    return ''.join(char_list)

def delete_file(path):
    if os.path.exists(path):
        os.remove(path)

def rewrite_content(path, sign, key, content):
    fwb = open(path, 'wb')
    fwb.write(HEADER_FLAG)
    fwb.write(encrypt_signkey(sign));
    fwb.write(encrypt_signkey(key));
    fwb.write(content)
    fwb.close()

def check_crypt_ex(file_path):
    fo = open(file_path, 'rb', True)
    head_flag = fo.read(6)
    fo.close()

    work_dir = os.getcwd()
    sign_key_file_path = os.path.join(work_dir,"signkey.txt")

    is_crypt_ex = False

    if head_flag == HEADER_FLAG:
        # 二次解密
        is_crypt_ex = True

        fo = open(file_path, 'rb', True)
        fo.seek(6)
        xxtea_sign = encrypt_signkey(fo.read(7))
        fo.seek(13)
        xxtea_key = encrypt_signkey(fo.read(16))
        fo.seek(29)
        real_content = fo.read()

        SIGN_KEY_DIC[file_path] = {'sign': xxtea_sign, 'key': xxtea_key}

        f = open(sign_key_file_path,'w')
        f.write(json.dumps(SIGN_KEY_DIC))
        f.close()

        delete_file(file_path)

        _f = open(file_path, 'wb')
        _f.write(real_content)
        _f.close()

        xxtea_cmd = '{0} {1} {2} {3}'.format(BIN_XXTEA, file_path, xxtea_key, xxtea_sign)
        os.system(xxtea_cmd)

    elif os.path.exists(sign_key_file_path):
        # 二次加密
        is_crypt_ex = True

        global REMOVE_SIGN_KEY_FILE
        REMOVE_SIGN_KEY_FILE = True

        sign_key_len = len(SIGN_KEY_DIC.keys())
        if sign_key_len <= 0:
            f = open(sign_key_file_path,'r')
            data = json.loads(f.read())
            f.close()
            SIGN_KEY_DIC.update(data)

        xxtea_sign = SIGN_KEY_DIC[file_path]['sign']
        xxtea_key = SIGN_KEY_DIC[file_path]['key']

        xxtea_cmd = '{0} {1} {2} {3}'.format(BIN_XXTEA, file_path, xxtea_key, xxtea_sign)
        os.system(xxtea_cmd)
            
        fsk = open(file_path, 'rb')
        real_content = fsk.read()
        fsk.close()

        delete_file(file_path)

        rewrite_content(file_path, xxtea_sign, xxtea_key, real_content);

    return is_crypt_ex

def delete_sign_key_file():
    work_dir = os.getcwd()
    sign_key_file_path = os.path.join(work_dir,"signkey.txt")
    delete_file(sign_key_file_path)

def xxtea_file(file_path, key = XXTEA_KEY, sign = XXTEA_SIGN):
    '''
    xxtea指定文件
    '''
    crypt_ex = check_crypt_ex(file_path)
    if not crypt_ex:
        xxtea_cmd = '{0} {1} {2} {3}'.format(BIN_XXTEA, file_path, key, sign)
        os.system(xxtea_cmd)


def xxtea_dir(dir_path, execpts = None, key = XXTEA_KEY, sign = XXTEA_SIGN):
    '''
    xxtea目录所有文件
    '''
    full_dir_path = full_dirname(dir_path)
    for (root, dirs, files) in os.walk(dir_path):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            rel_file_path = file_path.replace(full_dir_path, '')
            if check_xxtea_by_ext(rel_file_path) and not check_except(rel_file_path, execpts):
                xxtea_file(file_path, key, sign)


def recover_encode_dfs(assets_path, encode_dir, sign = ''):
    '''
    还原所有目录文件名
    '''
    full_assets_path = full_dirname(assets_path)
    encode_dir_path = os.path.join(assets_path, encode_dir)
    md5dfs_json = json.loads(open(MD5DFS_JSON_FILE, 'r').read())
    for (root, dirs, files) in os.walk(encode_dir_path):
        for file_name in files:
            file_path = os.path.join(root, file_name)
            rel_file_path = file_path.replace(full_assets_path, '')
            if md5dfs_json.has_key(rel_file_path):
                org_file_path = os.path.join(assets_path, md5dfs_json[rel_file_path])
                org_assets_path = os.path.dirname(org_file_path)
                if not os.path.exists(org_assets_path):
                    os.makedirs(org_assets_path)
                shutil.move(file_path, org_file_path)
    # 
    for root, dirs, files in os.walk(encode_dir_path):
        for dir_name in dirs:
            inner_assets_path = os.path.join(root, dir_name)
            if not os.listdir(inner_assets_path):
                shutil.rmtree(inner_assets_path)


def xgcrypt(src_df):
    '''
    解密加密资源
    '''
    # 
    key = XXTEA_KEY
    sign = XXTEA_SIGN
    if os.path.exists(src_df):
        if os.path.isfile(src_df):
            xxtea_file(src_df, key, sign)
        elif os.path.isdir(src_df):
            recover_encode_dfs(src_df, ENCODE_DIR)
            xxtea_dir(src_df, ['res/CG', 'script'], key, sign)

    if REMOVE_SIGN_KEY_FILE:
        delete_sign_key_file()

#############################################################################################################
if __name__ == '__main__':
    if len(sys.argv) > 1:
        xgcrypt(sys.argv[1])
    else:
        print '！！！缺少目录或文件！！！'

