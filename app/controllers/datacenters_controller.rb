class DatacentersController < ApplicationController

	def new
		@datacenter = Datacenter.new
	end

	def edit
		@datacenter = Datacenter.find(params[:id])
	end

	def create
		@datacenter = Datacenter.new(params[:datacenter])

		respond_to do |format|
			if @datacenter.save
				format.html { redirect_to([@datacenter, :server_racks], :notice => 'Datacenter was successfully created.') }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def update
		@datacenter = Datacenter.find(params[:id])

		respond_to do |format|
			if @datacenter.update_attributes(params[:datacenter])
				format.html { redirect_to([@datacenter, :server_racks], :notice => 'Datacenter was successfully updated.') }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@datacenter = Datacenter.find(params[:id])
		@datacenter.destroy

		respond_to do |format|
			format.html { redirect_to([current_datacenter, :server_racks], :notice => 'Datacenter was destroyed.') }
		end
	end
end
