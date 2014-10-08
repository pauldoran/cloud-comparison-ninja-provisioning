begin
  require 'vertx' 
rescue LoadError
end

require 'bundler/setup'
require 'fog'
require 'sinatra'
require 'securerandom'

EU_WEST_1_AMI = 'ami-7aa8080d'

set :port, 5555
set :environment, :production

post '/compute' do
  content_type :json
  
  body = JSON.parse(request.body.read, :symbolize_names => true)

  body[:compute].each do |compute|
    create_compute compute
  end
  
  {}
end

def create_compute(options)
  puts "Creating compute"
  case options[:provider].to_sym
    when :aws
      connection = Fog::Compute::AWS.new({
        :region => options[:region],
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
    when :google
      connection = Fog::Compute::Google.new({
        :google_project => options[:google_project]
      })

      instance_uuid = SecureRandom.uuid

      server = connection.servers.bootstrap(
        :zone_name => options[:zone_name],
        :name => instance_uuid,
        :image_name => options[:image_name],
        :machine_type => options[:machine_type],
        :username => options[:username]
      )
  end
  
  puts "Executing script"
  results = server.ssh "wget -o run.sh https://raw.githubusercontent.com/pauldoran/cloud-comparison-ninja-app/master/docker/run.sh && sudo bash run.sh #{instance_uuid} 2>&1"
  results.each do |result|
    puts result.stdout
  end
end
