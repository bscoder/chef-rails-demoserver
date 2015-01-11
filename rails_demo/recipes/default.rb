#
# Cookbook Name:: rails_demo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"

swap_file '/swap.img' do
  size      2048   # MBs
  persist   true
  action    :create
end

user "webmaster" do
  supports manage_home: true
  shell "/bin/bash"
  action [:create, :modify]
end

bash "copy auth_key" do
  code """
mkdir -p /home/webmaster/.ssh/
(test -f /home/ubuntu/.ssh/authorized_keys && cat /home/ubuntu/.ssh/authorized_keys > /home/webmaster/.ssh/authorized_keys ||
test -f /root/.ssh/authorized_keys && cat /root/.ssh/authorized_keys > /home/webmaster/.ssh/authorized_keys) &&
chown -R webmaster /home/webmaster/"""
   not_if "test -f /home/webmaster/.ssh/authorized_keys"
end

package "libapache2-mod-fcgid" do
  action :install
end

apache_module 'fcgid' do
  enable true
end

apache_module 'vhost_alias' do
  enable true
end

package "gawk" do ## rvm needs it 
  action :install
end

package "libfcgi-dev" do
  action :install
end

node.set[:rvm][:gpg_key] = 'BF04FF17'
node.set[:rvm][:installs] = {"webmaster" => true}
node.set[:rvm][:user_installs] = [
                                  {
                                   user: "webmaster",
                                   rubies: ["ruby-2.1.5"],
                                   install_rubies: true,
                                   default_ruby: "ruby-2.1.5"
                                  },
                                 ]


execute 'gpg key' do
  command "`which gpg2 || which gpg` --keyserver hkp://keys.gnupg.net --recv-keys #{node['rvm']['gpg_key']}"
  user "webmaster"
  environment 'HOME' => '/home/webmaster'
  only_if 'which gpg2 || which gpg'
  not_if { node['rvm']['gpg_key'].empty? }
end

include_recipe "rvm::user"

mysql_service 'default' do
  bind_address '127.0.0.1'
  port '3306'  
  initial_root_password 'SimplePassword4Root'
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end


node.set[:postgresql][:password][:postgres] = 'qweasd999'
node.set[:postgresql][:config_pgtune][:db_type] = 'web'
node.set[:postgresql][:config_pgtune][:max_connections] = '32'
node.set[:postgresql][:config_pgtune][:total_memory] = '102400kB'

include_recipe "postgresql"
include_recipe "postgresql::server"
include_recipe "postgresql::config_initdb"
include_recipe "postgresql::config_pgtune"


apache_site "default"
web_app "demos" do
  template 'apache_demo.conf.erb'
end
