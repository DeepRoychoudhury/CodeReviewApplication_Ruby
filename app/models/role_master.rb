class RoleMaster < ApplicationRecord
		validates :rolename, presence: true
		has_many :role_pages
		has_many :page_masters, through: :role_pages
end
