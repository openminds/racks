Feature: Api
  In order to see devices for a customer
  As a developer of another application
  I want to get the devices

Background:
	Given a company exists with customer_number: 123, name: "Testcompany"
	And a datacenter exists with name: "A datacenter"
	And a server_rack exists with name: "R1", datacenter: the datacenter
	And 42 units exist with server_rack: the server_rack
	And a  "2"U device exists inside the server_rack with name: "testdevice", company_names: "Testcompany"


Scenario: Get the data for the customer
	Given I post a correct secret and existing customer number
	Then the response should contain "testdevice"

Scenario: Try to get a company with a number that does not exist
	Given I post a correct secret and incorrect customer number
	Then the response should contain "No customer found with this number"

Scenario: Try to get a company with a number that does not exist
	Given I post an incorrect secret
	Then the response should contain "redirected"
