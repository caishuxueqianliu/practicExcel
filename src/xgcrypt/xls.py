from xlutils.copy import copy 
import xlrd
book1 = xlrd.open_workbook('./config.xls') 
book2 = copy(book1) 
sheet = book2.get_sheet(0) 
sheet.write(17,1,'common_review')

book2.save('config2.xls')