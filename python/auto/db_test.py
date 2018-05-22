import pymysql
conn = pymysql.connect(host='13.113.68.172', user='saiku', passwd="saiku", db='saiku')
cur = conn.cursor()
cur.execute("SELECT now() FROM dual")
for r in cur:
  print(r)
cur.close()
conn.close()