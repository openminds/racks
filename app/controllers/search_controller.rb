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

end
