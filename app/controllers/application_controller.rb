require "application_responder"

class ApplicationController < ActionController::Base
	self.responder = ApplicationResponder
	respond_to :html, :iphone

	protect_from_forgery

	before_filter :get_all_datacenters, :current_datacenter, :set_iphone_format

	protected
	def current_datacenter
		if params[:datacenter_id]
			@current_datacenter ||= Datacenter.find(params[:datacenter_id])
		elsif Datacenter.all.any?
			@current_datacenter = Datacenter.all.first
		else
			@current_datacenter = Datacenter.new
		end
		@current_datacenter
	end
	def current_server_rack
		@current_server_rack ||= current_datacenter.server_racks.find(params[:server_rack_id])
	end
	def current_device
		@current_device ||= current_server_rack.devices.find(params[:device_id])
	end
	def get_all_datacenters
		@datacenters = Datacenter.all
	end
	def is_iphone_request?
		request.user_agent =~ /(Mobile\/.+Safari)/
	end
	def set_iphone_format
		if is_iphone_request?
			request.format = :iphone
		end
	end


end
