require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "upload only zip" do  	
  	project=Project.new(ProjectName: "Uploadrbfile",Path: "slides_example.rb",Status: "A",user_id:"5")  	
   	assert_equal(false, project.save, "saved project even if it is not zip file")
  end

  test "project name should be unique" do
  	project=Project.new(ProjectName: "NewProject",Path: "slides_example.zip",Status: "A",user_id:"5")  	
   	assert_equal(false, project.save, "saved project even if name is already present")
  end

  test "path is required" do
  	project=Project.new(ProjectName: "RandomProject",Status: "A",user_id:"5")  	
   	assert_equal(false, project.save, "saved project even if path is not present")
  end
  
end
