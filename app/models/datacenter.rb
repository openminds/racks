class Datacenter < ActiveRecord::Base
	has_many :server_racks, :dependent => :destroy
	validates_presence_of :name, :message => "can't be blank"

	default_scope :order => "name ASC"

	define_index do
		indexes :name, :sortable => true
		indexes :comment
	end

	def my_path
		[self, :server_racks]
	end

	def search_label
		"#{self.name} (#{self.location})"
	end
end
