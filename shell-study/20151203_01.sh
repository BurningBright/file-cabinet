#!/bin/bash

#1. file the [alpha] + o combination
#2. replace it with group num 1 + O
#sed 's/\([[:alpha:]]\)o/\1O/g' log.20151202_1



#1. delete the blank line
#2. if it's not the last line then insert a blank line
#sed '/^$/d' log.20151202_1 | sed '$!G'

#1. set file line num
#2. delete the line break
#sed '=' log.20151202_1 | sed 'N; s/\n/  /'

#1. set lcg tag
#2. if it is last line then quit
#3. if the line num biger than 3 than delete the first line
#4. get back to lcg tag
#sed ':lcg; $q; N; 3,$D; b lcg' log.20151202_1

#1. find blank line
#2. get into multi line mode
#3. if find two blank line than delete fist blank
#*. find any not blank line to the nearest blank line, than not delete them
#sed '/^$/{N; /^\n$/D}' log.20151202_1
#sed '/./,/^$/!d' log.20151202_1

#1. find any not blank line to last line, than not delete them
#sed '/./,$!d' log.20151202_1

#1. set a tag 'lcg'
#2. if find a line break and it's next line is blank than
#3. read next line (blank one)
#4. if it is the last line than delete it
#5. get into multi line mode
#6. branch get back to tag 'lcg'
#sed ':lcg; /\n*$/{n; $d; N; b lcg}' log.20151202_1

#1. replace the html tag to null
#2. delete these blank line
#sed 's/<[^>]*>//g; /^\s*$/d' log.20151203_1
