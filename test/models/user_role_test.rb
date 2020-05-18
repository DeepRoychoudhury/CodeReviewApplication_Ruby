require 'test_helper'

class UserRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "check uniqueness of userid and rolemasterid" do
  	role=UserRole.new(user_id: "1",role_master_id: "1")
   	assert_equal(false, role.save, "Saved User Role even if User was linked to role")
  end

end
