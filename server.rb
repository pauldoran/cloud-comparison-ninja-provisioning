begin
  require 'vertx' 
rescue LoadError
end

require 'bundler/setup'
require 'fog'
require 'sinatra'
require 'securerandom'

US_WEST_1_AMI = 'ami-bb373ffe'
EU_WEST_1_AMI = 'ami-0a3c9a7d'

set :port, 5555
set :environment, :production

post '/compute' do
  content_type :json
  
  body = JSON.parse(request.body.read, :symbolize_names => true)

  create_compute body[:options]
  
  {}
end

def create_compute(options)
  puts "Creating compute"
  connection = Fog::Compute::AWS.new({
    :region => options[:region]
  })

  instance_uuid = SecureRandom.uuid

  server = connection.servers.bootstrap(
    :image_id => options[:image_id], 
    :flavor_id => options[:flavor_id], 
    #:key_name => 'ninja',
    #:public_key_path => '~/.ssh/id_rsa.pub', 
    #:private_key_path => '~/.ssh/ninja_id_rsa', 
    :username => options[:username]
  )
  
  puts "Executing script"
  server.ssh "wget https://raw.githubusercontent.com/pauldoran/cloud-comparison-ninja-app/master/docker/run.sh && bash run.sh #{instance_uuid}"
end
