require "application_system_test_case"

class CustomreviewrulesTest < ApplicationSystemTestCase
  setup do
    @customreviewrule = customreviewrules(:one)
  end

  test "visiting the index" do
    visit customreviewrules_url
    assert_selector "h1", text: "Customreviewrules"
  end

  test "creating a Customreviewrule" do
    visit customreviewrules_url
    click_on "New Customreviewrule"

    fill_in "Numberoflinesincontroller", with: @customreviewrule.numberoflinesincontroller
    fill_in "Numberoflinesinhelper", with: @customreviewrule.numberoflinesinhelper
    fill_in "Numberoflinesinmodel", with: @customreviewrule.numberoflinesinmodel
    fill_in "Numberoflinesinview", with: @customreviewrule.numberoflinesinview
    fill_in "Projectname", with: @customreviewrule.projectname
    fill_in "Reviewtype", with: @customreviewrule.reviewtype
    fill_in "User", with: @customreviewrule.user_id
    click_on "Create Customreviewrule"

    assert_text "Customreviewrule was successfully created"
    click_on "Back"
  end

  test "updating a Customreviewrule" do
    visit customreviewrules_url
    click_on "Edit", match: :first

    fill_in "Numberoflinesincontroller", with: @customreviewrule.numberoflinesincontroller
    fill_in "Numberoflinesinhelper", with: @customreviewrule.numberoflinesinhelper
    fill_in "Numberoflinesinmodel", with: @customreviewrule.numberoflinesinmodel
    fill_in "Numberoflinesinview", with: @customreviewrule.numberoflinesinview
    fill_in "Projectname", with: @customreviewrule.projectname
    fill_in "Reviewtype", with: @customreviewrule.reviewtype
    fill_in "User", with: @customreviewrule.user_id
    click_on "Update Customreviewrule"

    assert_text "Customreviewrule was successfully updated"
    click_on "Back"
  end

  test "destroying a Customreviewrule" do
    visit customreviewrules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customreviewrule was successfully destroyed"
  end
end
