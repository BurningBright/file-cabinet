import urllib2
import re

hdr = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
       'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
       'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
       'Accept-Encoding': 'none',
       'Accept-Language': 'en-US,en;q=0.8',
       'Connection': 'keep-alive'}

headers = {'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'}
#headers = {'User-Agent':'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'}

request = urllib2.Request("http://m.wuxiaworld.com/renegade-index/renegade-chapter-1/", headers = headers)
response = urllib2.urlopen(request, data=None, timeout=7)
data = response.read()


head = '<!DOCTYPE html>\
<html xmlns="http://www.w3.org/1999/xhtml" prefix lang="en-US">\
<head>\
<meta charset="UTF-8">\
</head>\
<body class="page-template-default page page-id-62153 page-child parent-pageid-42349 custom-background group-blog">\
'

foot = '</body>\
</html>'

#pattern = re.compile('(?s)<div itemprop="articleBody">.*?(?=<div class="code-block)')

pattern = re.compile('<div itemprop="articleBody">.*?(?=<div class="code-block)', re.S)
matcher = re.search(pattern, data)

cur = 1
# origin url
pAddInfo = re.compile('www.wuxiaworld.com/renegade-index/renegade-chapter-\d+/(?=">Previous)')
nAddInfo = re.compile('www.wuxiaworld.com/renegade-index/renegade-chapter-\d+/(?=">Next)')
# right url
pAddAWS = '52.26.149.200:8080/renegade-immortal/renegade-chapter-' + str(cur - 1) + '.html'
nAddAWS = '52.26.149.200:8080/renegade-immortal/renegade-chapter-' + str(cur + 1) + '.html'

article = pAddInfo.sub(pAddAWS, matcher.group(0))
article = nAddInfo.sub(nAddAWS, article)

#print article

f = open('renegade-chapter-' + str(cur)+ '.html', "a")
f.write(head + article + foot)

#print data
#print matcher.group(0)
#f = open("118.html", "a")
#f.write(data)
#print head + matcher.group(0) + foot

