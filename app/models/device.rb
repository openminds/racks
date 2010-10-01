class Device < ActiveRecord::Base
	has_many :units, :dependent => :nullify
	belongs_to :company
	has_many :interfaces
	
	def unit_ids(ids=[])
		ids.each do |id|
			unit = Unit.find(id)
			units << unit
		end
	end
	def unit_ids
		ids = []
		units.each do |unit|
			ids << unit.id
		end
		ids
	end
	
	def server_rack
		ServerRack.find(units.first.server_rack.id)
	end
end
