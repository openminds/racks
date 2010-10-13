class Datacenter < ActiveRecord::Base
	has_many :server_racks, :dependent => :destroy
	validates_presence_of :name, :message => "can't be blank"

	def paginated_server_racks(page=1)
		server_racks.paginate :page => page, :per_page => 5
	end
end
