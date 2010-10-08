class CompaniesController < ApplicationController
	def index
		@companies = Company.all(:order => 'name ASC')
	end

	def show
		@company = Company.find(params[:id])
	end

	def new
		@company = Company.new
	end

	def edit
		@company = Company.find(params[:id])
	end

	def create
		@company = Company.new(params[:company])

		respond_to do |format|
			if @company.save
				format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def update
		@company = Company.find(params[:id])

		respond_to do |format|
			if @company.update_attributes(params[:company])
				format.html { redirect_to(@company, :notice => 'Company was successfully updated.') }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@company = Company.find(params[:id])
		@company.destroy

		respond_to do |format|
			format.html { redirect_to(companies_url, :notice => 'Company deleted.') }
		end
	end
end