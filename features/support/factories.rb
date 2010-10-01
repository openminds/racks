Factory.define(:datacenter) do |d|
	d.sequence(:name){|n| "Datacenter#{n}"}
	d.sequence(:location){|n| "location for datacenter#{n}"}
	d.sequence(:comment){|n| "comment for datacenter #{n}"}
end