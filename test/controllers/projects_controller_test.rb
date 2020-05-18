require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "should get index" do
    get projects_index_url
    assert_response :success
  end

  test "should get new" do
    get new_user_project_url(:user_id => users)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_project_url(:user_id => users,:id => projects)
    assert_response :success
  end

#works with token
  # test "should get destroy" do
  #   get user_project_url(:user_id => users,:id => projects)
  #   assert_response :success
  # end

end
