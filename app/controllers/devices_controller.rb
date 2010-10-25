class DevicesController < ApplicationController
	def show
		@device = Device.find(params[:id])
		redirect_to(datacenter_server_rack_path(@device.server_rack.datacenter, @device.server_rack, :device => "#{@device.id}"), :notice => flash[:notice])
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
		respond_with @device.server_rack.datacenter, @device.server_rack, @device do |format|
			format.html
			format.iphone do
				if @device.errors.any?
					redirect_to [@device.server_rack.datacenter, @device.server_rack, @device, :new]
				else
					redirect_to [@device.server_rack.datacenter, @device.server_rack, @device]
				end
			end
		end
	end

	def update
		@device = Device.find(params[:id])

		@device.update_attributes(params[:device])
		respond_with @device.server_rack.datacenter, @device.server_rack, @device do |format|
			format.html
			format.iphone do
				if @device.errors.any?
					redirect_to [@device.server_rack.datacenter, @device.server_rack, @device, :edit]
				else
					redirect_to [@device.server_rack.datacenter, @device.server_rack, @device]
				end
			end
		end
	end

	def destroy
		@device = Device.find(params[:id])
		@device.destroy

		respond_with @device, :location => [current_datacenter, :server_racks] do
			format.html
			format.iphone {redirect_to [current_datacenter, current_server_rack]}
		end
	end
end
