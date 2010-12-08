class DevicesController < ApplicationController
	respond_to :iphone, :html
	before_filter :authorize
	cache_sweeper :device_sweeper, :only => [:create, :update, :destroy]
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
		@device.interfaces.build
	end

	def edit
		@device = Device.find(params[:id])
		@device.interfaces.build
	end

	def create
		@device = Device.new(params[:device])
		@device.save
		if request.format == :html
			@device.update_cable_connection
			if !@device.interfaces.any?
				@device.interfaces.build
			end
		end
		if @device.units.empty?
			@device.units << current_server_rack.units.available.first
		end
		respond_with @device.server_rack.datacenter, @device.server_rack, @device do |format|
			format.html
			format.iphone do
				if @device.errors.any?
					redirect_to new_datacenter_server_rack_device_path(@device.server_rack.datacenter, @device.server_rack, @device)
				else
					redirect_to [@device.server_rack.datacenter, @device.server_rack, @device]
				end
			end
		end
	end

	def update
		@device = Device.find(params[:id])
		@device.update_attributes(params[:device])
		if request.format == :html
			@device.update_cable_connection
			if !@device.interfaces.any?
				@device.interfaces.build
			end
		end
		if @device.units.empty?
			@device.units << current_server_rack.units.available.first
		end
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

		respond_with @device, :location => [current_datacenter, current_server_rack] do |format|
			format.html
			format.iphone {redirect_to [current_datacenter, current_server_rack]}
		end
	end
	def collect_interfaces
		selected_server_rack = ServerRack.find(params[:rack_id])
		@interfaces = selected_server_rack.available_interfaces
		if params[:interface_id]
			current_interface = Interface.find(params[:interface_id])
			if current_interface.other && current_interface.other.device.server_rack == selected_server_rack
				@interfaces << current_interface.other
			end
		end

		@collection = []
		
		@interfaces.each do |interface|
			@collection << {:value => interface.id, :type => interface.interface_type, :label => interface.to_s, :selected => (('selected') if interface.other == current_interface )}
		end
		@collection <<  {:value => nil, :type => nil, :label => "Disconnect"}
		respond_to do |format|
			format.json {render :json => @collection}
		end
	end
end
