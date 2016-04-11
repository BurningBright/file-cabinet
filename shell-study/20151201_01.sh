#!/bin/bash

#1. single line find 'love' line
#2. delete it's next line
#sed '/love/{n; d}' log.20151201_1

#1. multi line find line break
#2. replace it with '@' grobally
#sed 'N; s/\n/\@/g' log.20151201_1

#1. find the blank line
#2. multi line find '\nI_have'
#3. delete the front line break
#sed '/^$/{N; /\nI have/D}' log.20151201_1



#experiment the multi line mode possibility
#sed 'N; s/aa\naa/\@\@/g' log.20151201_2
#sed -n 'N; /aa\naaa/P; D' log.20151201_2
#sed -n 'N; /^aaa\naaaa$/P' log.20151201_2
