require 'test_helper'

class PrjReviewTest < ActiveSupport::TestCase
   #test "the truth" do
   #  assert true
   #end

   test "if exist dont create" do
   	prj_review=PrjReview.new(project_id: "28",review_id: "10",ReviewType: "D",ReviewValue: "50")
   	assert_equal(false, prj_review.save, "saved project review even if Project and Review are already present") 
   end


end
