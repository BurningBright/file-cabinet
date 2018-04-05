import datetime

now = datetime.datetime.now()
print now.strftime('%Y-%m-%d %H:%M:%S')
print now.strftime('%Y%m%d%H%M%S')

delta = datetime.timedelta(hours=8)
now = now + delta
print now.strftime('%Y-%m-%d %H:%M:%S')
print now.strftime('%Y%m%d%H%M%S')