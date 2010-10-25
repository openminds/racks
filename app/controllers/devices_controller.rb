class DevicesController < ApplicationController
	def show
		@device = Device.find(params[:id])
		respond_to do |format|
			format.html {redirect_to(datacenter_server_rack_path(@device.server_rack.datacenter, @device.server_rack, :device => "#{@device.id}"), :notice => flash[:notice])}
			format.iphone
		end
		
	end

	def new
		@device = Device.new
		@device.units  << current_server_rack.units.available.first
		@interfaces = current_server_rack.available_interfaces
		@device.interfaces.build
	end

	def edit
		@device = Device.find(params[:id])
		@device.interfaces.build
		@interfaces = current_server_rack.available_interfaces + @device.connected_to_interfaces
		@interfaces.uniq
		unless @device.interfaces.any?
			@device.interfaces.build
		end
	end

	def create
		@device = Device.new(params[:device])
		@device.save
		respond_with @device.server_rack.datacenter, @device.server_rack, @device
	end

	def update
		@device = Device.find(params[:id])

		@device.update_attributes(params[:device])
		respond_with @device.server_rack.datacenter, @device.server_rack, @device
	end

	def destroy
		@device = Device.find(params[:id])
		@device.destroy

		respond_with @device, :location => [current_datacenter, :server_racks]
	end
end
