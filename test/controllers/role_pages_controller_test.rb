require 'test_helper'

class RolePagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    
    @role_page = role_pages(:one)
  end

  test "should get index" do
    get role_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_role_page_url
    assert_response :success
  end

  test "should show role_page" do
    get role_page_url(@role_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_page_url(@role_page)
    assert_response :success
  end

  test "should update role_page" do
    patch role_page_url(@role_page), params: { role_page: { page_master_id: @role_page.page_master_id, role_master_id: @role_page.role_master_id } }
    assert_redirected_to role_page_url(@role_page)
  end

  test "should destroy role_page" do
    assert_difference('RolePage.count', -1) do
      delete role_page_url(@role_page)
    end

    assert_redirected_to role_pages_url
  end
end
