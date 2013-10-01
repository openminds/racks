Given /^a  "([^"]*)"U device exists inside the server_rack with name: "([^"]*)", company_names: "([^"]*)"$/ do |number_of_units, name, company_names|
  device = Device.new
  device.name = name
  device.company_names = company_names
  device.id = (Device.all.size + 1)
  1.upto(number_of_units.to_i) do |n|
    device.units << Unit.available.last
    device.save!
  end
  device
end
Given /^a  "([^"]*)"U device exists inside the server_rack with name: "([^"]*)"$/ do |number_of_units, name|
    device = Device.new
  device.name = name
  device.id = (Device.all.size + 1)
  1.upto(number_of_units.to_i) do |n|
    device.units << Unit.available.last
    device.save!
  end
  device
end
