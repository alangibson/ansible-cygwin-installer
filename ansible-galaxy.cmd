@echo off

set CYGWIN=C:\cygwin64
set SH=%CYGWIN%\bin\bash.exe

"%SH%" -c "/cygdrive/c/cygwin64/opt/ansible/bin/ansible-galaxy %*"
