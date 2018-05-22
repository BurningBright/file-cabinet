# -*- coding:utf-8 -*-
import urllib2
import pymysql
import json
import datetime
import sys
reload(sys)
sys.setdefaultencoding('utf8')

#ages        = [1973, 2004, 2005, 2006, 2007, 2008, 2010, 2011, 2012, 2013, 2014, 2015]
#years       = [8936, 317, 318, 319, 320, 321, 316, 2020, 2939, 3455, 4853, 6310]

ages = [1973, 2004, 2005, 2006, 2007, 2008, 2010, 2011, 2012, 2013, 2014, 2015]
years = [8936, 317, 318, 319, 320, 321, 316, 2020, 2939, 3455, 4853, 6310]
seriesCode  = 162
conn = pymysql.connect(host='13.113.68.172', user='saiku', passwd="saiku", db='saiku', use_unicode=True, charset="utf8")

def url_open(url):
    req = urllib2.Request(url)
    response = urllib2.urlopen(url)
    html = response.read()
    
    return html

def get_serie(age, yearCode):
    html = url_open('https://www.autohome.com.cn/ashx/series_allspec.ashx?s=' + str(seriesCode) + '&y=' + str(yearCode))
    
    # 先转unicode，再以utf8编码
    html = unicode(html, "gbk").encode("utf8")
    
    js = json.loads(html, encoding="utf8")
    
#    print json.dumps(js['Group'][0], ensure_ascii=False)
#    print json.dumps(js['Spec'][1]['Name'], ensure_ascii=False).lstrip('"').rstrip('"')
#    print json.dumps(js['Spec'][1]['Price'], ensure_ascii=False)
    
    cur = conn.cursor()
    
    cur.execute('SET NAMES utf8;')
    cur.execute('SET CHARACTER SET utf8;')
    cur.execute('SET character_set_connection=utf8;')
    
    for serie in js['Spec']:
        id = json.dumps(serie['Id'], ensure_ascii=False)
        name = json.dumps(serie['Name'], ensure_ascii=False)
        
        drivingModeName = json.dumps(serie['DrivingModeName'], ensure_ascii=False)
        if drivingModeName == '""': drivingModeName = "null"
        
        transmission = json.dumps(serie['Transmission'], ensure_ascii=False)
        if transmission == '""': transmission = "null"
        
        price = json.dumps(serie['Price'], ensure_ascii=False)
        if price == '' or price.find(u"万") < 0: price = "null"
        else: price = price.replace(u"万", '')
        
        link2Sc = json.dumps(serie['Link2Sc'], ensure_ascii=False)
        if link2Sc == '""': link2Sc = "null"
            
        state = json.dumps(serie['State'], ensure_ascii=False)
        
        ShowParas = json.dumps(serie['ShowParas'], ensure_ascii=False)
        if ShowParas == "true": ShowParas = '1' 
        else: ShowParas = '0'
        
        ShowTaxRelief = json.dumps(serie['ShowTaxRelief'], ensure_ascii=False)
        if ShowTaxRelief == "true": ShowTaxRelief = '1' 
        else: ShowTaxRelief = '0'
        
        ShowPreferential = json.dumps(serie['ShowPreferential'], ensure_ascii=False)
        if ShowPreferential == "true": ShowPreferential = '1' 
        else: ShowPreferential = '0'
        
        videoid = json.dumps(serie['videoid'], ensure_ascii=False)
        
        GroupName = json.dumps(serie['GroupName'], ensure_ascii=False)
        if GroupName == '""': GroupName = "null"
        
        p2sc = json.dumps(serie['Price2Sc'], ensure_ascii=False)
        if p2sc == '""': p2sc = "null"
        
#        print id + "  " + name + "  " + price + "  " + p2sc + "  " + str(ShowParas)
        sql = "insert into auto_series values(" + id + ',' + name + ',' + drivingModeName + ',' + transmission + ',' + price + ',' + link2Sc + ',' + state + ',' + ShowParas + ',' + ShowTaxRelief + ',' + ShowPreferential + ',' + videoid + ',' + GroupName + ',' + str(age) + ");"
        print sql
        try:
            cur.execute(sql)
        except Exception, e:
            print 'error'
        
    conn.commit()
    cur.close()
    

def get_serie_2sc(age, yearCode, date): 
    html = url_open('https://www.autohome.com.cn/ashx/series_allspec.ashx?s=' + str(seriesCode) + '&y=' + str(yearCode))
    
    # 先转unicode，再以utf8编码
    html = unicode(html, "gbk").encode("utf8")
    
    js = json.loads(html, encoding="utf8")
    
    cur = conn.cursor()
    
    cur.execute('SET NAMES utf8;')
    cur.execute('SET CHARACTER SET utf8;')
    cur.execute('SET character_set_connection=utf8;')
    
    for serie in js['Spec']:
        id = json.dumps(serie['Id'], ensure_ascii=False)
        p2sc = json.dumps(serie['Price2Sc'], ensure_ascii=False)
        if p2sc == '""' or p2sc.find(u"万") < 0: continue
        
        p2sc = p2sc.replace(u"万", '').replace(u"\"", '')
        
        p2sc_from, p2sc_to = ("null", "null")
        p2sc = p2sc.split("-")
        if len(p2sc) == 1:
            p2sc_from = p2sc[0]
        elif len(p2sc) == 2:
            p2sc_from = p2sc[0]
            p2sc_to   = p2sc[1]
        
        sql = "insert into auto_series_2sc values(" + id + ',' + p2sc_from + ',' + p2sc_to + ',"' + str(date) + "\");"
        print sql
        
        try:
            cur.execute(sql)
        except Exception, e:
            print e
        
    conn.commit()
    cur.close()
    
if __name__ == '__main__':
    
#    for index in range(len(ages)):
#        get_serie(ages[index], years[index])
    
    date = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    for index in range(len(ages)):
        get_serie_2sc(ages[index], years[index], date)
    
    conn.close()
    