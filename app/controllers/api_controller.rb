class ApiController < ApplicationController
	before_filter :authenticate_user!
	def get_devices_for_customer
		@customer = Company.find_by_customer_number(params[:customer_number])
	end
	
	private
	def authenticate_user!
		pre_shared_key = API_SECRET['pre_shared_key']
		local_secret = Digest::MD5.hexdigest( pre_shared_key + Date.today.to_s + params[:customer_number])
		unless params[:secret] == local_secret
			redirect_to admin_no_rights_path
		end
	end
end
