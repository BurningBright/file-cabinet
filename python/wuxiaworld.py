import time
import sys
import socket
import urllib2
import re

chapterStart = 197
chapterNum = 4
targetUrl = 'http://www.wuxiaworld.com/renegade-index/renegade-chapter-'

filePath = 'C:\\Users\\Chen\\Desktop\\Renegade-Immortal\\'

head = '<!DOCTYPE html>\
<html xmlns="http://www.w3.org/1999/xhtml" prefix lang="en-US">\
<head>\
<meta charset="UTF-8">\
</head>\
<body class="page-template-default page page-id-62153 page-child parent-pageid-42349 custom-background group-blog">\
'

foot = '</body>\
</html>'

headers = {'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'}


def __call__():
    try:
        request = urllib2.Request(targetUrl + str(i) + '/', headers = headers)
        response = urllib2.urlopen(request, data=None, timeout=7)
    except urllib2.URLError as e:
        print 'error 1'
        sys.stdout.flush()
        time.sleep(3)
        return __call__()
    except socket.timeout as e:  
        print 'out'
        sys.stdout.flush()
        time.sleep(3)
        return __call__()
    return response
'''
    except urllib2.HTTPError, e:
        #print e.fp.read()
        #sys.stdout.flush()
        print 'error 1'
        sys.stdout.flush()
        time.sleep(3)
        return __call__()
    except urllib2.URLError, e:
        #print e.fp.read()
        #sys.stdout.flush()
        print 'error 2'
        sys.stdout.flush()
        time.sleep(3)
        return __call__()
    except socket.timeout as e:
        #print e.fp.read()
        #sys.stdout.flush()
        print 'out'
        sys.stdout.flush()
        time.sleep(3)
        return __call__()
'''



for i in range(chapterStart, chapterStart + chapterNum):
#    request = urllib2.Request(targetUrl + str(i) + '/', headers = headers)
#    response = urllib2.urlopen(request, data=None, timeout=10)
    response = __call__()
    data = response.read()
    # pick data
    pattern = re.compile('<div itemprop="articleBody">.*?(?=<div class="code-block)', re.S)
    matcher = re.search(pattern, data)
    # origin url
    pAddInfo = re.compile('www.wuxiaworld.com/renegade-index/renegade-chapter-\d+/(?=">Previous)')
    nAddInfo = re.compile('www.wuxiaworld.com/renegade-index/renegade-chapter-\d+/(?=">Next)')
    # right url
    pAddAWS = '52.26.149.200:8080/renegade-immortal/renegade-chapter-' + str(i - 1) + '.html'
    nAddAWS = '52.26.149.200:8080/renegade-immortal/renegade-chapter-' + str(i + 1) + '.html'
    # replace url
    article = pAddInfo.sub(pAddAWS, matcher.group(0))
    article = nAddInfo.sub(nAddAWS, article)
    # output chapter
    f = open(filePath + 'renegade-chapter-' + str(i)+ '.html', "a")
    f.write(head + article + foot)
    f.close()
    print 'finish ' + str(i)
    sys.stdout.flush()
    # sleep a while
    time.sleep(3)
    


