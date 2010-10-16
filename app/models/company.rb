class Company < ActiveRecord::Base
	has_many :devices
	validates_presence_of :name, :message => "can't be blank"

	acts_as_url :url
	
	define_index do
		indexes :name, :sortable => true
		indexes :comment
	end
	
	def my_path
		[self]
	end
	
	def search_label
		self.name
	end
end
