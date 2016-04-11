#!/bin/bash
#test redirect

exec 2> log.20151105_1

echo this is begin
echo all next output will be directed

exec 1> log.20151105_2

echo this should be direct to testOut
echo this should be direct to testErr >&2
