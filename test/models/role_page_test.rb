require 'test_helper'

class RolePageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should only save for unique rolemasterid and pagemasterid" do
   	role=RolePage.new(role_master_id: "1",page_master_id: "1")
   	assert_equal(false, role.save, "Saved RolePage even if Role Master id and Page Master id was linked") 
  end

end
