require "application_system_test_case"

class PageMastersTest < ApplicationSystemTestCase
  setup do
    @page_master = page_masters(:one)
  end

  test "visiting the index" do
    visit page_masters_url
    assert_selector "h1", text: "Page Masters"
  end

  test "creating a Page master" do
    visit page_masters_url
    click_on "New Page Master"

    fill_in "Pagelink", with: @page_master.pagelink
    fill_in "Pagename", with: @page_master.pagename
    click_on "Create Page master"

    assert_text "Page master was successfully created"
    click_on "Back"
  end

  test "updating a Page master" do
    visit page_masters_url
    click_on "Edit", match: :first

    fill_in "Pagelink", with: @page_master.pagelink
    fill_in "Pagename", with: @page_master.pagename
    click_on "Update Page master"

    assert_text "Page master was successfully updated"
    click_on "Back"
  end

  test "destroying a Page master" do
    visit page_masters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page master was successfully destroyed"
  end
end
