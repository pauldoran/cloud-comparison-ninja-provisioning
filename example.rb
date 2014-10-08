begin
  require 'vertx' 
rescue LoadError
end

require 'bundler/setup'
require 'fog'

#server = Fog::Compute[:aws].servers.create(:region => 'eu-west-1', :image_id => 'ami-0a3c9a7d')

US_WEST_1_AMI = 'ami-bb373ffe'
EU_WEST_1_AMI = 'ami-0a3c9a7d'

connection = Fog::Compute::AWS.new({
  :region => 'eu-west-1'
})

server = connection.servers.bootstrap(:image_id => EU_WEST_1_AMI, :flavor_id => 'm3.medium', :private_key_path => '~/.ssh/id_rsa', :public_key_path => '~/.ssh/id_rsa.pub', :username => 'ubuntu')
