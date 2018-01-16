::@echo off
if exist \config_A\.gitconfig (
::使用公司配置
MOVE .gitconfig    \config_B\
MOVE \config_A\.gitconfig    \
) else (
::使用私人配置
MOVE .gitconfig    \config_A\
MOVE \config_B\.gitconfig    \
)
::exit