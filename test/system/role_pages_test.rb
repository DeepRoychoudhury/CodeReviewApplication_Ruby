require "application_system_test_case"

class RolePagesTest < ApplicationSystemTestCase
  setup do
    @role_page = role_pages(:one)
  end

  test "visiting the index" do
    visit role_pages_url
    assert_selector "h1", text: "Role Pages"
  end

  test "creating a Role page" do
    visit role_pages_url
    click_on "New Role Page"

    fill_in "Page master", with: @role_page.page_master_id
    fill_in "Role master", with: @role_page.role_master_id
    click_on "Create Role page"

    assert_text "Role page was successfully created"
    click_on "Back"
  end

  test "updating a Role page" do
    visit role_pages_url
    click_on "Edit", match: :first

    fill_in "Page master", with: @role_page.page_master_id
    fill_in "Role master", with: @role_page.role_master_id
    click_on "Update Role page"

    assert_text "Role page was successfully updated"
    click_on "Back"
  end

  test "destroying a Role page" do
    visit role_pages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role page was successfully destroyed"
  end
end
