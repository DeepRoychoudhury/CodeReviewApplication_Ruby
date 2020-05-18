require 'test_helper'

class UserRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "should get index" do
    get user_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_user_role_url
    assert_response :success
  end

  test "should show user_role" do
    get user_role_url(:id => user_roles)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_role_url(:id => user_roles)
    assert_response :success
  end

  test "should update user_role" do
    patch user_role_url(:id => user_roles), params: { user_role: { :role_master_id => user_roles, :user_id => user_roles } }
    
  end

  test "should destroy user_role" do
    assert_difference('UserRole.count', -1) do
      delete user_role_url(:id => user_roles)
    end

    assert_redirected_to user_roles_url
  end
end
