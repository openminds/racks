class ApplicationController < ActionController::Base
  protect_from_forgery
	
	protected
	def current_datacenter
		@current_datacenter ||= Datacenter.find(params[:datacenter_id])
	end
	def current_server_rack
		@current_server_rack ||= current_datacenter.server_racks.find(params[:server_rack_id])
	end
end
