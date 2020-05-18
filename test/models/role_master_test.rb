require 'test_helper'

class RoleMasterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save without Role Name" do
   	role=RoleMaster.new()
   	assert_equal(false, role.save, "Saved Role even if Role Name was not present") 
  end

end
