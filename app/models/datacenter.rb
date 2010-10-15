class Datacenter < ActiveRecord::Base
	has_many :server_racks, :dependent => :destroy
	validates_presence_of :name, :message => "can't be blank"
end
