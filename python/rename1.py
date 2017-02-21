import os
import os.path

# point to the target directory
dirpath = 'F:\\a\\'

for file in os.listdir(dirpath): 
	if os.path.isfile(os.path.join(dirpath, file)) == True:
		newname = '[BOMB.tv]' + file
		os.rename(os.path.join(dirpath, file),os.path.join(dirpath, newname)) 
		print (file,'ok')