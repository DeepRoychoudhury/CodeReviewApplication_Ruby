class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role_master
  validates_uniqueness_of :role_master_id, :scope => [:user_id], :message => ["category is already associated with given user "]
end
