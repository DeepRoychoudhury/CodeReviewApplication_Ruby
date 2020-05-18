class Fixprjreviewcolumnnremove < ActiveRecord::Migration[6.0]
  def change
  	  	def self.up
  		rename_column :prj_reviews, :id, :id
  		rename_column :prj_reviews, :project_id, :project_id
  		rename_column :prj_reviews, :review_id, :review_id
  		rename_column :prj_reviews, :ReviewType, :reviewtype
  		rename_column :prj_reviews, :ReviewValue, :reviewvalue
  		remove_column :prj_reviews, :created_at
  		remove_column :prj_reviews, :updated_at 
  	end
  end
end
