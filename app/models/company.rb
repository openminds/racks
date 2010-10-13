class Company < ActiveRecord::Base
	has_many :devices
	validates_presence_of :name, :message => "can't be blank"

	acts_as_url :url
end
