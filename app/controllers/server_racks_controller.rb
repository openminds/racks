class ServerRacksController < ApplicationController
	def index
		if !Datacenter.all.any?
			logger.debug "NONE FOUND!"
			redirect_to new_datacenter_path
		end
		@datacenters = Datacenter.all
		@current_datacenter = current_datacenter
	end
	def show
		@server_rack = ServerRack.find(params[:id])
	end

	def new
		@server_rack = current_datacenter.server_racks.build
	end

	def edit
		@server_rack = ServerRack.find(params[:id])
	end

	def create
		@server_rack = current_datacenter.server_racks.build(params[:server_rack])
		1.upto(params[:number_of_units].to_i) {|i| logger.debug  @server_rack.units << Unit.new(:number => i)}

		respond_to do |format|
			if @server_rack.save
				format.html { redirect_to([@server_rack.datacenter, @server_rack], :notice => 'Server rack was successfully created.') }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def update
		@server_rack = ServerRack.find(params[:id])

		respond_to do |format|
			if @server_rack.update_attributes(params[:server_rack])
				format.html { redirect_to([@server_rack.datacenter, @server_rack], :notice => 'Server rack was successfully updated.') }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@server_rack = ServerRack.find(params[:id])
		@server_rack.destroy

		respond_to do |format|
			format.html { redirect_to([current_datacenter, :server_racks], :notice => 'Server rack was successfully deleted.') }
		end
	end
end
