#!/bin/bash

# install chef
curl -L https://www.opscode.com/chef/install.sh | bash

# download bootstrap recipe
wget https://github.com/properflow/foundation-cookbook/archive/master.zip
unzip master.zip

# Install AWS EC2 API tools & Java via bootstrap recipe
/opt/bin/chef-solo -j /root/foundation-cookbook-master/node.json -c /root/foundation-cookbook-master/solo.rb
