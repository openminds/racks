class ServerRack < ActiveRecord::Base
	belongs_to :datacenter
	has_many :units
end
