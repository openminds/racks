Factory.define(:datacenter) do |d|
	d.sequence(:name){|n| "Datacenter#{n}"}
	d.sequence(:location){|n| "location for datacenter#{n}"}
	d.sequence(:comment){|n| "comment for datacenter #{n}"}
end
Factory.define(:server_rack) do |s|
	s.sequence(:name){|n| "Rack#{n}"}
	s.sequence(:comment){|n| "comment for rack #{n}"}
end