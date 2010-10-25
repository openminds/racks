class ServerRacksController < ApplicationController
	def index
		if !Datacenter.all.any?
			redirect_to new_datacenter_path
		end
		@current_datacenter = current_datacenter
		@server_racks = current_datacenter.server_racks.paginate :page => params[:page], :per_page => 5
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

		@server_rack.save
		respond_with @server_rack.datacenter, @server_rack do |format|
			format.html
			format.iphone do
				if @server_rack.errors.any?
					redirect_to [@server_rack.datacenter, :server_racks, :new]
				else
					redirect_to [@server_rack.datacenter, @server_rack]
				end
			end
		end
	end

	def update
		@server_rack = ServerRack.find(params[:id])
		@server_rack.update_attributes(params[:server_rack])
		respond_with @server_rack.datacenter, @server_rack do |format|
			format.html
			format.iphone do
				if @server_rack.errors.any?
					redirect_to [@server_rack.datacenter, @server_rack, :edit]
				else
					redirect_to [@server_rack.datacenter, @server_rack]
				end
			end
		end
	end

	def destroy
		@server_rack = ServerRack.find(params[:id])
		@server_rack.destroy

		respond_with current_datacenter, :server_racks, :notice => "Server rack was successfully destroyed." do |format|
			format.html
			format.iphone {redirect_to [current_datacenter, :server_racks]}
		end
	end
end
