#!/bin/bash
sed -e '1,20d;33,$d' log.20151126_1 | sed '/CREATE/c hahaha'
echo ----------------------------------------------
sed -e '1,20d;33,$d' log.20151126_1 | sed '/CREATE/i hahaha'
echo ----------------------------------------------
sed -e '1,20d;33,$d' log.20151126_1 | sed '/CREATE/a hahaha'
