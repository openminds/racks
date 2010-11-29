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
	require 'thinking_sphinx/deploy/capistrano'
end

#Shared secerts aren't in version control
namespace :secretsconfig do
	desc "Create secrets.yml in shared/config"
	task :copy_secrets_config do
		run "mkdir -p #{shared_path}/config"
		put File.read('config/secrets.yml'), "#{shared_path}/config/secrets.yml"
	end

	desc "Link in the production secrets.yml"
	task :link do
		run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
	end
end

after('deploy:update_code') do
  secretsconfig.link
	thinking_sphinx.rebuild
end

after 'deploy:setup' do
  secretsconfig.copy_secrets_config
end

