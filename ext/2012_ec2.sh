#!/bin/bash

AMI=ami-5ce32034
OS=Win2012

echo "Start $(date)"
knife ec2 server create --image ${AMI} --flavor m1.small -g sg-d0d44fb5,sg-13f69876 --user-data $HOME/projects/windows/windows-instance-data-winrm.ps1 -x chef -P 'chef' -r 'recipe[iis_test::vdir]' 
echo "End $(date)"

/usr/local/bin/terminal-notifier -title 'An Windows' -message "${OS} is done"
