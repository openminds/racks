When /^option "([^"]*)" from "([^"]*)" should be disabled$/ do |label, field|
	select = find(:xpath, XPath::HTML.select(field), :message => "Select list not found")
	option = select.find(:xpath, XPath::HTML.option(label), :message => "Option not found")
	raise 'Option was enabled' if option['disabled'] == 'false'
end

When /^option "([^"]*)" from "([^"]*)" should be enabled$/ do |label, field|
	select = find(:xpath, XPath::HTML.select(field), :message => "Select list not found")
	option = select.find(:xpath, XPath::HTML.option(label), :message => "Option not found")
	raise 'Option was disabled' if option['disabled'] == 'true'
end
Then /^debugging_info$/ do
	server_rack = ServerRack.all.last
	server_rack.units.each do |unit|
		puts "Unit: #{unit.number}"
	end
end
When /^I follow "([^"]*)" in the "([^"]*)" fieldset$/ do |link_name, fieldset_title|
	within_fieldset(fieldset_title) do
		click_link(link_name)
	end
end
Then /^the device should have "([^"]*)" "([^"]*)" interfaces$/ do |number, type|
	counter = 0
	Device.all.last.interfaces.each do |interface|
		counter+=1 if interface.interface_type?(type)
	end
	raise 'not the correct amount of interfaces' if counter != number.to_i
end