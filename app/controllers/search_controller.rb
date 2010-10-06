class SearchController < ApplicationController
  def search_companies
		@companies = Company.all
		data = []
		@companies.each do |company|
			data << {:label => company.name, :value => company.id}
		end
		respond_to do |format|
			format.json { render :json => data }
		end
  end
	
	def search
		@searchword = params[:s]
		@found_companies = Company.where("name LIKE :term OR comment LIKE :term", :term => "%#{@searchword}%").order("name ASC")
		@found_offers = Device.where('name LIKE :term OR comment like :term', :term => "%#{@searchword}%" ).order('name ASC')
		@found_racks = ServerRack.where('name LIKE :term OR comment LIKE :term', :term => "%#{@searchword}%").order('name ASC')
	end

end
