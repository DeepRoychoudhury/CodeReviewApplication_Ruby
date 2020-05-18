require 'test_helper'

class RoleMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    
    @role_master = role_masters(:one)
  end

  test "should get index" do
    get role_masters_url
    assert_response :success
  end

  test "should get new" do
    get new_role_master_url
    assert_response :success
  end

  test "should create role_master" do
    assert_difference('RoleMaster.count') do
      post role_masters_url, params: { role_master: { rolename: @role_master.rolename } }
    end

    assert_redirected_to role_master_url(RoleMaster.last)
  end

  test "should show role_master" do
    get role_master_url(@role_master)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_master_url(@role_master)
    assert_response :success
  end

  test "should update role_master" do
    patch role_master_url(@role_master), params: { role_master: { rolename: @role_master.rolename } }
    assert_redirected_to role_master_url(@role_master)
  end

#This test case will only work if the role is not linked to any role page
  #test "should destroy role_master" do
  #  assert_difference('RoleMaster.count', -1) do
  #    delete role_master_url(@role_master)
  #  end

  #  assert_redirected_to role_masters_url
  #end
end
