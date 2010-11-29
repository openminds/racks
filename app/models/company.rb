class Company < ActiveRecord::Base
	has_and_belongs_to_many :devices
	validates_presence_of :name, :message => "can't be blank"
	validates_uniqueness_of :name
	validates_uniqueness_of :customer_number, :allow_nil => true
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
