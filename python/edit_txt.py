import re
import os
import os.path

dirpath = 'F:\\Users'
pattern = '</head>'
css = '<link rel="stylesheet" href="./style.css"></head>'

for file in os.listdir(dirpath): 
    # read all text
    origin = open(os.path.join(dirpath, file), 'r+').readlines()
    # edit target line
    origin[0] = re.compile(pattern).sub(css, origin[0])
    # rewrite whole file
    open(os.path.join(dirpath, file), 'w+').writelines(origin)
