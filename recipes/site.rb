#
# Cookbook Name:: iis_test
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#
include_recipe 'windows'
include_recipe 'iis'

# stop and delete the default site
iis_site 'Default Web Site' do
  action [:stop, :delete]
end

# create and start a new site that maps to
# the physical location C:\inetpub\wwwroot\testfu
iis_site 'Testfu Site' do
  protocol :http
  port 80
  path "#{node['iis']['docroot']}/testfu"
  site_id 10
  action [:add,:config,:start]
end

