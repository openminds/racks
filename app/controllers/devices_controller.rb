class DevicesController < ApplicationController
	def show
		@device = Device.find(params[:id])
		redirect_to(datacenter_server_rack_path(@device.server_rack.datacenter, @device.server_rack, :device => "show_device_#{@device.id}"), :notice => flash[:notice])
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
		respond_to do |format|
			if @device.save
				format.html { redirect_to([@device.server_rack.datacenter, @device.server_rack, @device], :notice => 'Device was successfully created.') }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def update
		@device = Device.find(params[:id])
		
		respond_to do |format|
			if @device.update_attributes(params[:device])
				format.html { redirect_to([@device.server_rack.datacenter, @device.server_rack, @device], :notice => 'Device was successfully updated.') }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@device = Device.find(params[:id])
		@device.destroy

		respond_to do |format|
			format.html { redirect_to(request.referrer, :notice => 'Device was successfully deleted.') }
		end
	end
end
