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
	u.sequence(:number) do |n|
		if n>42
			n=1
		end
		n
	end
end
Factory.define(:company) do |c|
	c.sequence(:name){|n| "Company#{n}"}
end
Factory.define :admin, :class => 'user' do |u|
	u.email 'admin@openminds.be'
	u.password '123456'
	u.rights 'admin'
end
Factory.define :user_with_acces, :class => 'user' do |u|
	u.email 'info@openminds.be'
	u.password '123456'
	u.rights 'acces_granted'
end
Factory.define(:user) do |u|
	u.sequence(:email){|n| "Contact#{n}@company.be"}
	u.sequence(:password){|n| "#{n*99}#{n*99}#{n*99}#{n*99}#{n*99}#{n*99}"}
end
