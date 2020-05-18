class PageMaster < ApplicationRecord
	has_many :role_pages
	has_many :role_masters, through: :role_pages
end
