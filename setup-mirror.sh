#!/bin/bash

# reload
sudo -u apache pulp-manage-db

pulp-admin login --user=admin --password=admin

pulp-admin rpm repo create --repo-id=foreman

pulp-admin rpm repo update --repo=foreman --display-name='Foreman'

# First upload just one file

wget http://yum.theforeman.org/releases/latest/el7/x86_64/foreman-release.rpm \
     -O /tmp/foreman-release.rpm

pulp-admin rpm repo uploads rpm  --repo-id=foreman -f /tmp/foreman-release.rpm 

# Possibley add feed

#pulp-admin rpm repo update --repo=foreman --feed="http://yum.theforeman.org/releases/1.7/el7/x86_64"
