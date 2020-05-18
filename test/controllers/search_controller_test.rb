require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "should get index" do
    get search_index_url
    assert_response :success
  end

end
