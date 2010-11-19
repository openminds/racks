load 'deploy' if respond_to?(:namespace) # cap2 differentiator
require 'thinking_sphinx/deploy/capistrano'
set :user, "racks2010"
set :application, "racks"

set :repository, "git://github.com/openminds/racks.git"

server 'service-001.openminds.be', :app, :web, :db, :primary => true

set :whenever_command, "bundle exec whenever"

begin
	require 'openminds_deploy/defaults'
	require 'openminds_deploy/git'
	require 'openminds_deploy/passenger'
	require 'openminds_deploy/rails3'
	require 'whenever/capistrano'
	
end

