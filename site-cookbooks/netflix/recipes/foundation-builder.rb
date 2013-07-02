#
# Cookbook Name:: netflix
# Recipe:: foundation-builder
#
# Copyright 2013, Netflix, Inc.
# TODO add Apache license
#
# Sets up the ec2 tools and stuff needed for creating a foundation AMI

# disable i386
file "/etc/dpkg/dpkg.cfg.d/multiarch" do
  action :delete
end

# didn't want to install the apt lwrp
bash "apt-get update" do
  user "root"
  code <<-EOH
apt-get update
EOH
end

package "openjdk-7-jdk"
package "unzip"

# TODO do an unless exists check here
user "ubuntu" do
  home "/home/ubuntu"
  shell "/bin/bash"
  supports :manage_home => true
end

remote_file "/tmp/ec2-api-tools.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip"
  owner "ubuntu"
  mode "0755"
end

directory "/apps/aws" do
  owner "ubuntu"
  group "ubuntu"
  mode "0755"
  recursive true
  action :create
end

bash "unzip ec2-api-tools" do
  user "root"
  cwd "/apps/aws"
  code <<-EOH
    if [ ! -d /tmp/ec2-api-tools.zip ]
    then
        unzip -o /tmp/ec2-api-tools.zip
    fi
    EOH
end

file "/etc/environment" do
  owner "root"
  group "root"
  mode "0644"
  content <<-EOH
PATH="/apps/aws/ec2-api-tools-1.6.7.4/bin:/usr/local/aws/ec2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
EC2_HOME=/apps/aws/ec2-api-tools-1.6.7.4
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
EC2_URL=https://ec2.us-west-1.amazonaws.com
EOH
end
