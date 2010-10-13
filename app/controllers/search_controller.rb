class SearchController < ApplicationController
	def ajax_search
		@devices = Device.all(:conditions => ['name LIKE ?', "%#{params[:term]}%"], :order => 'name ASC')
		@server_racks = ServerRack.all(:conditions => ['name LIKE ?', "%#{params[:term]}%"], :order => 'name ASC')
		@datacenters = Datacenter.all(:conditions => ['name LIKE ?', "%#{params[:term]}%"], :order => 'name ASC')
		@companies = Company.all(:conditions => ['name LIKE ?', "%#{params[:term]}%"], :order => 'name ASC')
		@search = []

		@devices.each do |device|
			@search << {:label => device.name, :category => 'Devices', :value => device.id, :url => datacenter_server_rack_device_path(device.server_rack.datacenter, device.server_rack, device) }
		end
		@server_racks.each do |server_rack|
			@search << {:label => "#{server_rack.name} in #{server_rack.datacenter.name}", :category => 'Racks', :value => server_rack.id, :url => datacenter_server_rack_path(server_rack.datacenter, server_rack) }
		end
		@datacenters.each do |datacenter|
			@search << {:label => datacenter.name, :category => 'Datacenters', :value => datacenter.id, :url => datacenter_path(datacenter) }
		end
		@companies .each do |company|
			@search << {:label => company.name, :category => 'Companies', :value => company.id, :url => company_path(company) }
		end
		respond_to do |format|
			format.json {render :json => @search }
		end
	end

	def find_colors
		@colors = CableConnection.where("color LIKE :term", :term => "%#{params[:term]}%").collect {|c| c.color}
		@colors.uniq
		respond_to do |format|
			format.json {render :json => @colors }
		end
	end

	def search
		@searchword = params[:s]
		@found_companies = Company.where("name LIKE :term OR comment LIKE :term", :term => "%#{@searchword}%").order("name ASC")
		@found_devices = Device.where('name LIKE :term OR comment like :term', :term => "%#{@searchword}%" ).order('name ASC')
		@found_racks = ServerRack.where('name LIKE :term OR comment LIKE :term', :term => "%#{@searchword}%").order('name ASC')
		@found_datacenters = Datacenter.all(:conditions => ['name LIKE :term or comment LIKE :term', :term =>"%#{@searchword}%"], :order => 'name ASC')
	end

end
