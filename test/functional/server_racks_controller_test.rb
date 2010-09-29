require 'test_helper'

class ServerRacksControllerTest < ActionController::TestCase
  setup do
    @server_rack = server_racks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:server_racks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create server_rack" do
    assert_difference('ServerRack.count') do
      post :create, :server_rack => @server_rack.attributes
    end

    assert_redirected_to server_rack_path(assigns(:server_rack))
  end

  test "should show server_rack" do
    get :show, :id => @server_rack.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @server_rack.to_param
    assert_response :success
  end

  test "should update server_rack" do
    put :update, :id => @server_rack.to_param, :server_rack => @server_rack.attributes
    assert_redirected_to server_rack_path(assigns(:server_rack))
  end

  test "should destroy server_rack" do
    assert_difference('ServerRack.count', -1) do
      delete :destroy, :id => @server_rack.to_param
    end

    assert_redirected_to server_racks_path
  end
end
