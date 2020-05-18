class PrjReview < ApplicationRecord
  belongs_to :Project
  belongs_to :Review
  validates_uniqueness_of :project_id, :scope => [:review_id], :message => ["category is already associated with given review "]
end
