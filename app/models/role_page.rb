class RolePage < ApplicationRecord
  belongs_to :role_master
  belongs_to :page_master


  validates_uniqueness_of :role_master_id, :scope => [:page_master_id], :message => ["category is already associated with given page "]
end
