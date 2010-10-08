class Unit < ActiveRecord::Base
	belongs_to :server_rack
	belongs_to :device, :dependent => :destroy
	
	scope :available, :conditions => {:device_id => nil}
end
