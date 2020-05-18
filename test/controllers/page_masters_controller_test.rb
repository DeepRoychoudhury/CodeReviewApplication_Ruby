require 'test_helper'

class PageMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    
    @page_master = page_masters(:one)
  end

  test "should get index" do
    get page_masters_url
    assert_response :success
  end

  test "should get new" do
    get new_page_master_url
    assert_response :success
  end

  test "should create page_master" do
    assert_difference('PageMaster.count') do
      post page_masters_url, params: { page_master: { pagelink: @page_master.pagelink, pagename: @page_master.pagename } }
    end

    assert_redirected_to page_master_url(PageMaster.last)
  end

  test "should show page_master" do
    get page_master_url(@page_master)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_master_url(@page_master)
    assert_response :success
  end

  test "should update page_master" do
    patch page_master_url(@page_master), params: { page_master: { pagelink: @page_master.pagelink, pagename: @page_master.pagename } }
    assert_redirected_to page_master_url(@page_master)
  end

#This test case will only work if the page is not linked to any role
  #test "should destroy page_master" do
  #  assert_difference('PageMaster.count', -1) do
  #    delete page_master_url(@page_master)
  #  end

  #  assert_redirected_to page_masters_url
  #end
end
