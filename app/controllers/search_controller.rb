class SearchController < ApplicationController
	before_filter :authorize
	respond_to :iphone, :html
	def search
		@searchword = params[:s] || params[:term]
		respond_to do |format|
			format.json do
				@results = ThinkingSphinx.search("*#{@searchword}*")
				@search = []
				@results.compact.each do |result|
					# logger.debug url_for(result.my_path)
					@search << {:value => result.search_label, :category => result.class.name, :url => url_for(result.my_path) }
				end
				render :json => @search.sort_by {|result| result[:category]} 
			end
			format.html do
				@found_server_racks = ServerRack.search("*#{@searchword}*")
				@found_datacenters = Datacenter.search("*#{@searchword}*")
				@found_companies = Company.search("*#{@searchword}*")
				@found_devices = Device.search("*#{@searchword}*")
			end
			format.iphone do
				@found_server_racks = ServerRack.search("*#{@searchword}*")
				@found_datacenters = Datacenter.search("*#{@searchword}*")
				@found_devices = Device.search("*#{@searchword}*")
			end
		end
	end
	
	def find_colors
		#@colors = CableConnection.where("color LIKE :term", :term => "%#{params[:term]}%").map{ |cable| cable.color.downcase}
		@colors = ConvertColors.colors.map(&:name).collect do |color|
			color if color.downcase.include?(params[:term].downcase)
		end.compact!
		logger.debug @colors
		respond_to do |format|
			format.json {render :json => @colors }
		end
	end
	def company_names
		@device_names = Company.where("name LIKE :term", :term => "%#{params[:term]}%").map(&:name)
		@device_names.uniq!
		respond_to do |format|
			format.json {render :json => @device_names }
		end
	end
end
