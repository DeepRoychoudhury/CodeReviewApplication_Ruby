require "application_system_test_case"

class PrjReviewsTest < ApplicationSystemTestCase
  setup do
    @prj_review = prj_reviews(:one)
  end

  test "visiting the index" do
    visit prj_reviews_url
    assert_selector "h1", text: "Prj Reviews"
  end

  test "creating a Prj review" do
    visit prj_reviews_url
    click_on "New Prj Review"

    fill_in "Project", with: @prj_review.Project_id
    fill_in "Reviewtype", with: @prj_review.ReviewType
    fill_in "Reviewvalue", with: @prj_review.ReviewValue
    fill_in "Review", with: @prj_review.Review_id
    click_on "Create Prj review"

    assert_text "Prj review was successfully created"
    click_on "Back"
  end

  test "updating a Prj review" do
    visit prj_reviews_url
    click_on "Edit", match: :first

    fill_in "Project", with: @prj_review.Project_id
    fill_in "Reviewtype", with: @prj_review.ReviewType
    fill_in "Reviewvalue", with: @prj_review.ReviewValue
    fill_in "Review", with: @prj_review.Review_id
    click_on "Update Prj review"

    assert_text "Prj review was successfully updated"
    click_on "Back"
  end

  test "destroying a Prj review" do
    visit prj_reviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Prj review was successfully destroyed"
  end
end
