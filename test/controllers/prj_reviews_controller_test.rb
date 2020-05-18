require 'test_helper'

class PrjReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    
    @prj_review = prj_reviews(:one)
  end

  test "should get index" do    
    get '/prj_reviews'
    assert_response :success
  end

  test "should get new" do
    get new_prj_review_url
    assert_response :success
  end

  test "should show prj_review" do
    get prj_review_url(@prj_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_prj_review_url(@prj_review)
    assert_response :success
  end

  test "should destroy prj_review" do
    assert_difference('PrjReview.count', -1) do
      delete prj_review_url(@prj_review)
    end

    assert_redirected_to prj_reviews_url
  end
end
