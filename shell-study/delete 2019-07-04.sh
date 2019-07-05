#!/bin/sh
find /usr/xxx/logs/ -mtime +30 -name '*.*' -exec rm -rf {} \;