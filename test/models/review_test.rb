require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save without Review Name" do
   	review=Review.new(FileType: "Controller",ReviewValue: "30")
   	assert_equal(false, review.save, "Saved Review even if Review Name was not present") 
  end

  test "should not save without Review Value" do
   	review=Review.new(FileType: "View",ReviewName: "Number of lines")
   	assert_equal(false, review.save, "Saved Result even if Review Value was not present")   	
  end

end
