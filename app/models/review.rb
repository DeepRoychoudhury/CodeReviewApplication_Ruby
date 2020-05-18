class Review < ApplicationRecord
	has_many :prj_reviews
	validates :ReviewName, presence: true
	validates :ReviewValue, presence: true
end
