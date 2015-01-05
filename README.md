ansible-cygwin-installer
========================

Install Ansible on Windows under Cygwin

This Powershell script will download and install Cygwin and Ansible. Since Ansible is officially Linux-only, it is necessary to install and execute it on Windows via Cygwin.

Run from Powershell

    Set-ExecutionPolicy bypass
    & ansible-cygwin-installer.ps1

Run from cmd with

    powershell -ExecutionPolicy bypass "ansible-cygwin-installer.ps1"

