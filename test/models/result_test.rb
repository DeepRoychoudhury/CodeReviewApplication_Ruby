require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "No Duplicate Projects" do
   	result=Result.new(Folder_Name: "NewProject",Type_Of_File: "Controller",FileName: "something.rb",Error_Line_Number: "50",Error_Description: "Syntax",project_id: "5")
   	assert_equal(false, result.save, "Saved Result even if same Project was already present")   	
  end

end
