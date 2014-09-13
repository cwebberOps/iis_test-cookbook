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

iis_vdir 'Default Web Site/' do
  action :config
  path '/Content/Test'
  physical_path 'C:\wwwroot\shared\test1'
end
