class ApiController < ApplicationController
	def get_devices_for_customer
		@customer = Company.find_by_customer_number(params[:customer_number])
	end
end
