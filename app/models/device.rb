class Device < ActiveRecord::Base
	has_many :units, :dependent => :nullify
	belongs_to :company
	has_many :interfaces, :dependent => :destroy
	accepts_nested_attributes_for :interfaces, :allow_destroy => true, :reject_if => :all_blank

	validates_presence_of :name, :message => "can't be blank"


	define_index do
		indexes :name, :sortable => true
		indexes :comment
	end

	#after_save :update_cable_connection

	enumerate :device_type, :with => DeviceType

	def cable_connections
		interfaces.map(&:cable_connection).flatten.compact.uniq
	end

	def connected_to_interfaces
		interfaces.inject([]) do |connected_to, interface|
			if interface.cable_connection
				connected_to << interface.other
			end
			connected_to
		end
	end

	def server_rack
		units.first.server_rack
	end


	def update_cable_connection
		self.interfaces.each do |i|
			i.update_cable_connection
		end
	end
	

	def my_path
		[self.server_rack.datacenter, self.server_rack, self]
	end

	def company_name
		if company
			company.name
		else
			"Openminds"
		end
	end

	def search_label
		"#{self.name} (#{company_name})"
	end
end
