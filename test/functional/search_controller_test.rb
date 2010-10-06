require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get search_companies" do
    get :search_companies
    assert_response :success
  end

end
