class Unit < ActiveRecord::Base
	belongs_to :server_rack
	belongs_to :device
end
