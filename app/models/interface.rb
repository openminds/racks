class Interface < ActiveRecord::Base
	belongs_to :device
	belongs_to :connection
	#accepts_nested_attributes_for :conntection
	
	enumerate :interface_type do
		value :id => 1, :name => 'Ethernet'
		value :id => 2, :name => 'Power'
	end
end
