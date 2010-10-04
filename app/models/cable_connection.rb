class CableConnection < ActiveRecord::Base
	has_one :left_interface, :class_name => 'interface'
	has_one :right_interface, :class_name => 'interface'
end
