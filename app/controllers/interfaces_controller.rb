class InterfacesController < ApplicationController
	def new
		@interface = current_device.interfaces.build
		@interfaces = current_server_rack.available_interfaces - @interface.device.interfaces
	end

	def edit
		@interface = Interface.find(params[:id])
		@interfaces = current_server_rack.available_interfaces - @interface.device.interfaces << @interface.other
	end

	def create
		@interface = current_device.interfaces.build(params[:interface])
		@interface.save
		@interface.update_cable_connection
		respond_with @interface.device.server_rack.datacenter, @interface.device.server_rack, @interface.device do |format|
			format.html
			format.iphone do
				if @interface.errors.any?
					redirect_to [:new, @interface.device.server_rack.datacenter, @interface.device.server_rack, @interface.device, @interface]
				else
					redirect_to [@interface.device.server_rack.datacenter, @interface.device.server_rack, @interface.device]
				end
			end
		end
	end

	def update
		@interface = Interface.find(params[:id])

		@interface.update_attributes(params[:interface])
		@interface.update_cable_connection
		respond_with @interface.device.server_rack.datacenter, @interface.device.server_rack, @interface.device do |format|
			format.html
			format.iphone do
				if @interface.errors.any?
					redirect_to [:edit, @interface.device.server_rack.datacenter, @interface.device.server_rack, @interface.device, @interface]
				else
					redirect_to [@interface.device.server_rack.datacenter, @interface.device.server_rack, @interface.device]
				end
			end
		end
	end

	def destroy
		@interface = Interface.find(params[:id])
		@interface.destroy
		respond_with @interface, :location => [current_datacenter, current_server_rack, current_device] do |format|
			format.html
			format.iphone {redirect_to [current_datacenter, current_server_rack, current_device]}
		end
	end
	

	

end
