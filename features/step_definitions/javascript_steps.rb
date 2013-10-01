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