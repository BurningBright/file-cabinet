# -*- coding:utf-8 -*-
import sys
reload(sys)
sys.setdefaultencoding('utf8')

# u'\u4e07'
a = u"万"
print a
print ord(a)
print unichr(ord(a))

print "----------------"

b = a.encode('utf8')
print b
c = a.encode('gbk')
print c