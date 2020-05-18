require "application_system_test_case"

class RoleMastersTest < ApplicationSystemTestCase
  setup do
    @role_master = role_masters(:one)
  end

  test "visiting the index" do
    visit role_masters_url
    assert_selector "h1", text: "Role Masters"
  end

  test "creating a Role master" do
    visit role_masters_url
    click_on "New Role Master"

    fill_in "Rolename", with: @role_master.rolename
    click_on "Create Role master"

    assert_text "Role master was successfully created"
    click_on "Back"
  end

  test "updating a Role master" do
    visit role_masters_url
    click_on "Edit", match: :first

    fill_in "Rolename", with: @role_master.rolename
    click_on "Update Role master"

    assert_text "Role master was successfully updated"
    click_on "Back"
  end

  test "destroying a Role master" do
    visit role_masters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role master was successfully destroyed"
  end
end
