Given /^I am using an iPhone$/ do
	add_headers('HTTP_USER_AGENT' => "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0_2 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A400 Safari/6531.22.7")
end
Given /^I am using a regular browser$/ do
  add_headers('HTTP_USER_AGENT' => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5")
end