require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get no_rights" do
    get :no_rights
    assert_response :success
  end

end
