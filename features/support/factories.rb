Factory.define(:datacenter) do |d|
	d.sequence(:name){|n| "Datacenter#{n}"}
	d.sequence(:location){|n| "location for datacenter#{n}"}
	d.sequence(:comment){|n| "comment for datacenter #{n}"}
end
Factory.define(:server_rack) do |s|
	s.sequence(:name){|n| "Rack#{n}"}
	s.sequence(:comment){|n| "comment for rack #{n}"}
end
Factory.define(:device) do |d|
	d.sequence(:name){|n| "Device#{n}"}
	d.device_type 1
end
Factory.define(:unit) do |u|
	u.sequence(:number){|n| n}
end
