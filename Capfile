load 'deploy' if respond_to?(:namespace) # cap2 differentiator
set :user, "racks2010"
set :application, "racks"

set :repository, "git://github.com/openminds/racks.git"

server 'service-001.openminds.be', :app, :web, :db, :primary => true
begin
	require 'openminds_deploy/defaults'
	require 'openminds_deploy/git'
	require 'openminds_deploy/passenger'
	require 'openminds_deploy/rails3'
end
desc "Start and index Sphinx"
task :start_sphinx, :roles => :db do
	run "cd #{release_path} && rake ts:in" rescue nil
	run "cd #{release_path} && rake ts:start" rescue nil
end
desc "Update the crontab file"
task :update_crontab, :roles => :db do
	run "cd #{release_path} && whenever --update-crontab #{application}  --set 'environment=production'" rescue nil
end
