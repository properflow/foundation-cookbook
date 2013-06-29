#!/bin/bash

# install chef
curl -L https://www.opscode.com/chef/install.sh | bash

# download bootstrap recipe
wget https://github.com/properflow/foundation-cookbook/archive/master.zip
apt-get install unzip
unzip master.zip

# Install AWS EC2 API tools & Java via bootstrap recipe
/opt/chef/bin/chef-solo -j /root/foundation-cookbook-master/node.json -c /root/foundation-cookbook-master/solo.rb

# update PATH
# TODO: don't hard-code ec2-api-tools version
echo 'PATH="/apps/aws/ec2-api-tools-1.6.7.4/bin:/usr/local/aws/ec2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"' > /etc/environment

