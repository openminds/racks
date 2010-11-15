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
		end
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
		# Very dirty hack to get around the TypeMismatchError see : https://rails.lighthouseapp.com/projects/8994/tickets/189-activerecord-associationtypemismatch-with-same-class-name-added-helpful-exception-message
		# @device.interfaces_attributes = params[:device][:interfaces_attributes]  
		# params[:device][:unit_ids].each do |id|            
		# 	unit = Unit.find(id)                            
		# 	@device.units << unit                           
		# end                                                
		# @device.name = params[:device][:name]              
		# @device.comment = params[:device][:comment]        
		# @device.device_type = params[:device][:device_type]
		# if @device.valid?
		# 	@device.save 	# does not catch errors
		# end                                          
		## Would have been:
		@device.update_attributes(params[:device])
		if request.format == :html
			@device.update_cable_connection
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
end
