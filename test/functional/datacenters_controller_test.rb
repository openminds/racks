require 'test_helper'

class DatacentersControllerTest < ActionController::TestCase
  setup do
    @datacenter = datacenters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datacenters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datacenter" do
    assert_difference('Datacenter.count') do
      post :create, :datacenter => @datacenter.attributes
    end

    assert_redirected_to datacenter_path(assigns(:datacenter))
  end

  test "should show datacenter" do
    get :show, :id => @datacenter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @datacenter.to_param
    assert_response :success
  end

  test "should update datacenter" do
    put :update, :id => @datacenter.to_param, :datacenter => @datacenter.attributes
    assert_redirected_to datacenter_path(assigns(:datacenter))
  end

  test "should destroy datacenter" do
    assert_difference('Datacenter.count', -1) do
      delete :destroy, :id => @datacenter.to_param
    end

    assert_redirected_to datacenters_path
  end
end
