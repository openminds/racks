class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable, :lockable and :timeoutable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me

	# First user is an admin
	before_create :first_user_is_admin

	state_machine :rights, :initial => :acces_denied do
		event :denied do
			transition any => :acces_denied
		end
		event :granted do
			transition any => :acces_granted
		end
		event :admin do
			transition any => :admin
		end
	end
	
	def first_user_is_admin
		if User.all.size ==0
			self.rights = 'admin'
		end
	end
	
end
