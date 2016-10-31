#
# Cookbook Name:: dsc_test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'powershell'


user 'tcate' do
  action :create
  comment 'Thomas Cate'
  password 'p@ssw0rd'
end

group 'Remote Desktop Users' do
  action :modify
  members ['tcate']
  append true
end


dsc_resource "Allow IIS Rule" do
  resource :xfirewall
  property :name, "Allow Webserver"
  property :direction, "inbound"
  property :action, "allow"
  property :protocol, "tcp"
  property :localport, [ "80", "443" ]
  property :ensure, "Present"
  property :enabled, "True"
end