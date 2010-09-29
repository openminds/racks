class Device < ActiveRecord::Base
	has_many :units
	belongs_to :company
	has_many :interfaces
end
