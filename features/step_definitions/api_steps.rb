Given /^I post a correct secret and existing customer number$/ do
  post "/api/get_devices_for_customer/123", {:secret => Digest::MD5.hexdigest(API_SECRET['pre_shared_key'] + Date.today.to_s + 123.to_s)}
end
Then /^the response should contain "([^"]*)"$/ do |arg1|
	if !response.body.include?(arg1)
		raise "Did not contain the data"
	end
end
Given /^I post a correct secret and incorrect customer number$/ do
  post "/api/get_devices_for_customer/789", {:secret => Digest::MD5.hexdigest(API_SECRET['pre_shared_key'] + Date.today.to_s + 789.to_s)}
end
Given /^I post an incorrect secret$/ do
  post "/api/get_devices_for_customer/123", {:secret => "Something incorrect"}
end