class SearchController < ApplicationController
	def search
		@searchword = params[:s] || params[:term]
		respond_to do |format|
			format.json do
				@results = ThinkingSphinx.search("*#{@searchword}*")
				@search = []
				@results.each do |result|
					# logger.debug url_for(result.my_path)
					@search << {:label => result.search_label, :category => result.class.name, :value => result.id, :url => url_for(result.my_path) }
				end
				render :json => @search 
			end
			format.html do
				@found_server_racks = ServerRack.search("*#{@searchword}*")
				@found_datacenters = Datacenter.search("*#{@searchword}*")
				@found_companies = Company.search("*#{@searchword}*")
				@found_devices = Device.search("*#{@searchword}*")
			end
		end
	end

	def find_colors
		@colors = CableConnection.where("color LIKE :term", :term => "%#{params[:term]}%").map(&:color)
		@colors.uniq!
		respond_to do |format|
			format.json {render :json => @colors }
		end
	end
end
