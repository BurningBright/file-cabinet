#!/bin/bash
echo "http://nvswi2lb.onuwy2dpovsxi5dffzrw63i.erenta.ru/products/rotation/70/4379_70_6061/0000.jpg" | 
gawk --re-interval '$0 ~ /[0-9]{4}\.jpg$/{
tmp=substr($0, 0, match($0, /[0-9]{4}\.jpg/, var) - 1)

# print index($0, /[0-9]{4}\.jpg/) --wrong

for(test in var) {
	printf "%s	%s\n", test, var[test]
}

print tmp
for(i=0; i<24; i++) {
	if(i<10)
		printf "%s000%s.jpg\n", tmp, i
	else
		printf "%s00%s.jpg\n", tmp, i
}

}'
