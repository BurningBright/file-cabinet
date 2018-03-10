import time
import sys
import socket
import urllib2
import re

targetUrl = ("xxx", "xxx")

filePath = 'C:\\Users\\Administrator\\Desktop\\xxx\\'

headers = {'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'}


def __call__(i):
    try:
        request = urllib2.Request(targetUrl[i], headers = headers)
        response = urllib2.urlopen(request, data=None, timeout=7)
    except urllib2.URLError as e:
        print 'error 1'
        sys.stdout.flush()
        time.sleep(1)
        return __call__(i)
    except socket.timeout as e:  
        print 'out request'
        sys.stdout.flush()
        time.sleep(1)
        return __call__(i)
    except Exception, e:
        print 'base'
        sys.stdout.flush()
        time.sleep(1)
        return __call__(i)
    
    return response



#for i in range(chapterStart, chapterStart + chapterNum):
#    request = urllib2.Request(targetUrl + str(i) + '/', headers = headers)
#    response = urllib2.urlopen(request, data=None, timeout=10)


for i in range(0, len(targetUrl)) :
    response = __call__(i)
    try:
        data = response.read()
    except socket.timeout as e:  
        print 'out read'
        sys.stdout.flush()
        i -= 1
        continue
    except Exception, e:
        print 'base read'
        sys.stdout.flush()
        i -= 1
        continue
    
    # replace
    remove = re.compile('http[s]://(?!fonts).*')
    data = remove.sub('', data)
    # font
    data = data.replace('fr-view"', 'fr-view" style="font-size: 55px;"')
    
    # name
    pattern = re.compile('chapter.*', re.S)
    name = re.search(pattern, targetUrl[i])
    
    # output chapter
    f = open(filePath + name.group(0) + '.html', "a")
    f.write(data)
    f.close()
    print 'finish ' + str(i) + ' ' + name.group(0)
    
    i += 1
    sys.stdout.flush()
    # sleep a while
    time.sleep(1)
    


