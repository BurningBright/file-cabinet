import os
import sys

dirpath = 'F:\\a\\'

#three parameters: parent directory, all directory name, all file names
for parent,dirnames,filenames in os.walk(dirpath):
	for filename in filenames:
		old = "%s/%s" %(dirpath, filename)
		new = "%s/%s" %(dirpath, "[BOMB.tv]" + filename)
		os.rename(old, new)
		
	#out put directory info
	for dirname in dirnames:
		print ("parent is:" + parent)
		print ("dirname is:" + dirname)
	
	#out put file info
	for filename in filenames:
		print ("parent is:" + parent)
		print ("filename is:" + filename)
		print ("the full name of the file is:" + os.path.join(parent,filename))