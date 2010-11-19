load 'deploy' if respond_to?(:namespace) # cap2 differentiator
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
desc "Start and index Sphinx"
task :start_sphinx, :roles => :db do
	run "cd #{current_release} && rake ts:in RAILS_ENV=production" rescue nil
	run "cd #{current_release} && rake ts:restart RAILS_ENV=production" rescue nil
end
