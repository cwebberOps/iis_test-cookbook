#!/bin/bash

AMI=ami-9ade1df2
OS=Win2012R2

echo "Start $(date)"
knife ec2 server create --image $AMI --flavor m1.small -g sg-d0d44fb5,sg-13f69876 --user-data $HOME/projects/windows/windows-instance-data-winrm.ps1 -x chef -P 'chef' -r 'recipe[iis_test::site]'
echo "End $(date)"

/usr/local/bin/terminal-notifier -title 'An Windows' -message "${OS} is done"
