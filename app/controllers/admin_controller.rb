class AdminController < ApplicationController
	respond_to :iphone, :html
	before_filter :authorize, :except => :no_rights
  	def no_rights
  	end

	def index
		@users = User.all(:order => 'created_at DESC')
	end

	def grant_user_rights
		@user = User.find(params[:user_id])
		@user.rights = 'acces_granted'
		@user.save!
		flash[:notice] = 'User can now use the application'
		redirect_to request.referrer
	end
	def grant_admin_rights
		@user = User.find(params[:user_id])
		@user.rights = 'admin'
		@user.save!
		flash[:notice] = 'User is now admin'
		redirect_to request.referrer
	end
	def delete_user
		@user = User.find(params[:user_id])
		@user.destroy
		flash[:notice] = 'User deleted'
		redirect_to request.referrer
	end

	private
	def authorize
		if user_signed_in?
			unless current_user.admin?
				flash[:notice] = "You can't come here yet, wait for an admin to grant you the rights"
				redirect_to admin_no_rights_path
			end
		end
	end

end
