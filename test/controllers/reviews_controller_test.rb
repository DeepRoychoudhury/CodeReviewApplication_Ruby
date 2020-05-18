require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
  end

  test "should get index" do
    get reviews_index_url
    assert_response :success
  end

  test "should get new" do
    get '/reviews/new'
    assert_response :success
  end

  test "should get edit" do
    get edit_review_url(:id => reviews)
    assert_response :success
  end

  test "should get destroy" do
    get reviews_url
    assert_response :success
  end

end
