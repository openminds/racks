class CompaniesController < ApplicationController
	before_filter :authorize
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
		@company.save
		respond_with @company
	end

	def update
		@company = Company.find(params[:id])

		@company.update_attributes(params[:company])
		respond_with @company
	end

	def destroy
		@company = Company.find(params[:id])
		@company.destroy

		respond_with @company
	end
end