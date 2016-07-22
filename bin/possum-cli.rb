require 'gli'

include GLI::App

program_desc "Command and control application for Possum"

version File.read(File.expand_path("../VERSION", File.dirname(__FILE__)))

# Attempt to connect to the database.
def connect
  require 'sequel'
  
  def test_select
    begin
      db = Sequel::Model.db = Sequel.connect(ENV['DATABASE_URL'])
      db['select 1'].first
    rescue
      false
    end
  end
  
  30.times do
    break if test_select
    $stderr.write '.'
    sleep 1
  end

  raise "Database is still unavailable. Aborting!" unless test_select
  
  true
end

desc 'Run the application server'
command :server do |c|
  c.desc 'Policy file to load into the server'
  c.arg_name 'file_name'
  c.flag [ :f, :file ]

  c.desc 'Server listen port'
  c.arg_name 'port'
  c.default_value ENV['PORT'] || '80'
  c.flag [ :p, :port ]

  c.desc 'Server bind address'
  c.default_value ENV['BIND_ADDRESS'] || '0.0.0.0'
  c.arg_name 'address'
  c.flag [ :b, :'bind-address' ]
  
  c.action do |global_options,options,args|
    exit_now! "No command arguments are allowed" unless args.empty?

    connect

    system "rake db:migrate" or exit $?.exitstatus
    system "rake token-key:generate" or exit $?.exitstatus
    
    if file_name = options[:file]
      system "rake policy:load[#{file_name}]" or exit $?.exitstatus
    end
    
    exec "rackup -p #{options[:port]} -o #{options[:'bind-address']}"
  end
end

desc "Manage the policy"
command :policy do |cgrp|
  cgrp.desc "Load the policy from a file"
  cgrp.arg_name "file_name"
  cgrp.command :load do |c|
    c.action do |global_options,options,args|
      file_name = args.shift or exit_now! "Expecting file_name argument"
      exit_now! "No additional command arguments are allowed" unless args.empty?
  
      connect

      exec "rake policy:load[#{file_name}]"
    end
  end
  
  cgrp.desc "Watch a file and reload the policy if it's modified"
  cgrp.long_desc <<-DESC
To trigger a reload of the policy, replace the contents of the watched file with the path to 
the policy. Of course, the path must be visible to the container which is running "possum watch".
This can be a separate container from the application server. Both the application server and the
policy watcher should share the same backing database.


Example:


$ docker run -d possum watch /run/possum/policy/load)"
  DESC
  cgrp.arg_name 'file_name'
  cgrp.command :watch do |c|
    c.action do |global_options,options,args|
      file_name = args.shift or exit_now! "Expecting file_name argument"
      exit_now! "No additional command arguments are allowed" unless args.empty?

      connect

      exec "rake policy:watch[#{file_name}]"
    end
  end
end

desc "Manage the data encryption key"
command :"data-key" do |cgrp|
  cgrp.desc "Generate a data encryption key"
  cgrp.long_desc <<-DESC
Use this command to generate a new Base64-encoded 256 bit data encrytion key.
Once generated, this key should be placed into the environment of the Possum 
server. It will be used to encrypt all sensitive data which is stored in the 
database, including the token-signing private key.


Example:


$ export POSSUM_DATA_KEY="$(docker run --rm possum data-key generate)"
  DESC
  cgrp.command :generate do |c|
    c.action do |global_options,options,args|
      exit_now! "No command arguments are allowed" unless args.empty?
    
      exec "rake data-key:generate"
    end
  end
end

desc "Manage the token-signing key"
command :"token-key" do |cgrp|
  cgrp.desc "Generate and save the token signing key"
  cgrp.long_desc <<-DESC
Use this command to generate and store a new 2048-bit RSA private key, used to 
sign auth tokens. The POSSUM_DATA_KEY must be available in the environment
when this command is called, since it's used to encrypt the token-signing key
in the database.


Example:


$ docker run --rm possum token-key generate
  DESC
  cgrp.command :generate do |c|
    c.action do |global_options,options,args|
      exit_now! "No command arguments are allowed" unless args.empty?
      
      connect

      exec "rake token-key:generate"
    end
  end
end

desc "Manage the database"
command :db do |cgrp|
  cgrp.desc "Create and/or upgrade the database schema"
  cgrp.command :migrate do |c|
    c.action do |global_options,options,args|
      exit_now! "No command arguments are allowed" unless args.empty?
      
      connect
      
      exec "rake db:migrate"
    end
  end
end

exit run(ARGV)