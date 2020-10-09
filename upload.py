from selenium import webdriver
import os

# from pykeyboard import PyKeyboard
# from pymouse import PyMouse
# import pyperclip
# import time

driver = webdriver.Chrome("/usr/local/bin/chromedriver")
file_path = 'http://iosaudit.xuegaogame.com/public/?'
driver.get(file_path)
driver.find_element_by_tag_name("input").send_keys ('xuegao666')
driver.find_element_by_tag_name("button").click()

# 定位上传按钮，添加本地文件
#driver.find_element_by_name("file").send_keys('D:\\upload_file.txt')


#driver.quit()

driver.find_element_by_id("createbtn").click()
# driver.find_element_by_id("createbtn").click()
# k = PyKeyboard()
# m = PyMouse()
# filepath = '/'
# k.press_keys(['Command', 'Shift', 'G'])
# x_dim, y_dim = m.screen_size()
# m.click(x_dim // 2, y_dim // 2, 1)
# # 复制文件路径开头的斜杠/
# pyperclip.copy('/Users/admin/Desktop/practiceExcel/upload.py')
# # 粘贴斜杠/
# k.press_keys(['Command', 'V'])
# # 输入文件全路径进去
# k.type_string(file)
# k.press_key('Return')
# time.sleep(2)
# k.press_key('Return')
# time.sleep(2)
