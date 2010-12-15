class CableConnection < ActiveRecord::Base
	belongs_to :left_interface, :class_name => 'interface'
	belongs_to :right_interface, :class_name => 'interface'
	validates_uniqueness_of :left_interface_id, :scope => [:left_interface_id, :right_interface_id]
	validates_uniqueness_of :right_interface_id, :scope => [:left_interface_id, :right_interface_id]

	validates_inclusion_of :color, :in => ConvertColors.colors.map(&:name).collect {|c| c.downcase}, :allow_nil => true, :allow_blank => true

	before_validation do
		if self.color
			self.color.downcase!
		end
	end
	def other_interface(interface)
		if left_interface_id == interface.id
			other_interface = Interface.find(self.right_interface_id)
		else
			other_interface = Interface.find(self.left_interface_id)
		end
	end
end