class Result < ApplicationRecord
  belongs_to :Project
  # validates_uniqueness_of :project_id, :scope => [:Type_Of_File], :message => ["is already associated with given file type for review. "]
end
