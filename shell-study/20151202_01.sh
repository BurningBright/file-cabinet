#!/bin/bash

#1. find '1' begin line
#2. print it, pattern the next line
#3. copy all the pattern line to the hold space
#4. print old line
#5. add the pattern line to the hold space
#6. print old line
#7. copy all the hold line to the pattern space -> print pattern line
#8. add the hold line to the pattern space -> print pattern line
#sed -n '/^1/{p; n; h; p; H; p; g; p; G; p}' log.20151202_1

#1. if it's first line then not add it to hould space
#2. copy all the hould line to pattern space
#3. if it's last line then print it
#sed -n '{1!G; h; $p}' log.20151202_1

#1. if line num between 2 & 3 then set tag 'lcg'
#2. replace 'no' with 'yes'
#3. tag 'lcg' set here, if jump here it will skip #2 operation
#4. replace ' ' with ',' only once
#sed -n '{2,3b lcg; s/no/yes/; :lcg; s/ /,/1p}' log.20151202_1

#1. pattern num '2'
#2. replace 'pat' with 'dog'
#3. test if #2 success then jump tag 'lcg'
#4. replace ' ' with ',' only once
sed -n '/2/{s/pat/dog/;t lcg; :lcg; s/ /,/1p}' log.20151202_1
