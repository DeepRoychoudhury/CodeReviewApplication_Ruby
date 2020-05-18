require "application_system_test_case"

class ResultsTest < ApplicationSystemTestCase
  setup do
    @result = results(:one)
  end

  test "visiting the index" do
    visit results_url
    assert_selector "h1", text: "Results"
  end

  test "creating a Result" do
    visit results_url
    click_on "New Result"

    fill_in "Error description", with: @result.Error_Description
    fill_in "Error line number", with: @result.Error_Line_Number
    fill_in "Filename", with: @result.FileName
    fill_in "Folder name", with: @result.Folder_Name
    fill_in "Project", with: @result.Project_id
    fill_in "Type of file", with: @result.Type_Of_File
    click_on "Create Result"

    assert_text "Result was successfully created"
    click_on "Back"
  end

  test "updating a Result" do
    visit results_url
    click_on "Edit", match: :first

    fill_in "Error description", with: @result.Error_Description
    fill_in "Error line number", with: @result.Error_Line_Number
    fill_in "Filename", with: @result.FileName
    fill_in "Folder name", with: @result.Folder_Name
    fill_in "Project", with: @result.Project_id
    fill_in "Type of file", with: @result.Type_Of_File
    click_on "Update Result"

    assert_text "Result was successfully updated"
    click_on "Back"
  end

  test "destroying a Result" do
    visit results_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Result was successfully destroyed"
  end
end
