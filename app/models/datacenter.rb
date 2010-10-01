class Datacenter < ActiveRecord::Base
	has_many :server_racks, :dependent => :destroy
end
