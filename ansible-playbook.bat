@echo off

set CYGWIN=C:\cygwin64
set SH=%CYGWIN%\bin\bash.exe

"%SH%" -c "/bin/ansible-playbook %*"
