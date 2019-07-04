#!/bin/sh
find /usr/dcs/logs/ -mtime +30 -name '*.*' -exec rm -rf {} \;