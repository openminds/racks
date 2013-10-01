class Device < ActiveRecord::Base
	has_many :units, :dependent => :nullify
	has_and_belongs_to_many :companies
	has_many :interfaces, :dependent => :destroy
	accepts_nested_attributes_for :interfaces, :allow_destroy => true, :reject_if => :all_blank

	validates_presence_of :name, :message => "can't be blank"
	validate :validate_units


	define_index do
		indexes :name, :sortable => true
		indexes :comment
		indexes companies.name
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

	def company_names
		if companies.any?
			names = ""
			companies.each do |company|
				names += "#{company.name}, "
			end
			names
		else
			"Openminds"
		end
	end
	def company_names=(names)
		companies_to_add = []
		names.split(", ").each do |name|
			unless name == "Openminds"
				company = Company.find_or_create_by_name(name)
				companies_to_add << company
			end
		end
		self.companies = companies_to_add
	end


	def search_label
		"#{self.name} (#{company_names})"
	end

	private
	def validate_units
		errors.add(:units, "can't be empty") if self.units.empty?
	end
end
