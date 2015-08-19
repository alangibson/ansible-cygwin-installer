#
# This Powershell script will download and install Cygwin and Ansible.
#
# Run from Powershell
#    Set-ExecutionPolicy bypass
#    & ansible-cygwin-installer.ps1
#
# Run from cmd with
#    powershell -ExecutionPolicy bypass ".\ansible-cygwin-installer.ps1"
#

#
# User variables. These may be changed to suit your environment.
#

$storageDir = $pwd
$cygwinHome = "c:\tools\cygwin"
$cygwinUrlRoot = "http://cygwin.com"
$getPipUrlRoot = "https://bootstrap.pypa.io"
$cygwinMirror = "http://cygwin.mirrors.pair.com"

#
# You shouldn't normally need to change anything below here
#

if ($ENV:PROCESSOR_ARCHITECTURE -eq 'AMD64') {
    $cygwinSetupExe = "setup-x86_64.exe"
    $url = "$cygwinUrlRoot/$cygwinSetupExe"
    $file = "$storageDir\$cygwinSetupExe"
} elseif ($ENV:PROCESSOR_ARCHITECTURE -eq 'x86') {
    $cygwinSetupExe = "setup-x86.exe"
    $url = "$cygwinUrlRoot/$cygwinSetupExe"
    $file = "$storageDir\$cygwinSetupExe"
} else {
    echo 'Unknown processor architecture'
    exit
}

# Fully qualified path to Cygwin setup.exe
$cygwinSetupPath = "$storageDir\$cygwinSetupExe"

# Download Cygwin setup.exe, if it doesn't already exist
if ( ! ( Test-Path -Path $cygwinSetupPath -PathType Leaf ) ) {
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($url,$file)
}

$cygwinSetupArgs = '--no-admin', '-q', '-R', "$cygwinHome", '-s', "$cygwinMirror", '--packages="wget,python,git,vim,make,openssh,openssl,openssh-devel,libsasl2,ca-certificates,python-crypto,python-openssl,python-setuptools,dash,rebase"'
Start-Process -FilePath $cygwinSetupPath -ArgumentList $cygwinSetupArgs -Wait

# Add cygwin bin dir to path
$ENV:PATH="$cygwinHome\bin;$ENV:PATH"

# Install pip
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', """wget.exe $getPipUrlRoot/get-pip.py""" -Wait -NoNewWindow
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"python2.7.exe get-pip.py"' -Wait -NoNewWindow

# Fix fork() errors on some systems
Start-Process -FilePath $cygwinHome\bin\dash.exe -ArgumentList '-c', '"/usr/bin/rebaseall -v"' -Wait -NoNewWindow

# Install Ansible via pip
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"pip2.7 install ansible"' -Wait -NoNewWindow

# Run Ansible from outside of Cygwin shell
Start-Process -FilePath $cygwinHome\bin\bash.exe -ArgumentList '-c', '"ansible --version"' -Wait -NoNewWindow
