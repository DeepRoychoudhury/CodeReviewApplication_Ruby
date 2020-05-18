class Project < ApplicationRecord
  belongs_to :user
  has_many :prj_reviews, dependent: :destroy
   has_one :note, dependent: :destroy
   has_many :results, dependent: :destroy
  mount_uploader :Path, PathUploader # Tells rails to use this uploader for this model.
  validates :ProjectName, presence: true # Make sure the owner's name is present.
  validates :Path, presence: true
   validates_uniqueness_of :ProjectName, inclusion: { scope: :user_id, 
    message: "ProjectName should be unique" }
end
