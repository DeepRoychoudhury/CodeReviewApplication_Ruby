require 'test_helper'

class WelcomeuserControllerTest < ActionDispatch::IntegrationTest
setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "should get welcome" do
    get "/"
    assert_response :success
  end

end
