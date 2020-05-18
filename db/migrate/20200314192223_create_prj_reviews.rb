class CreatePrjReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :prj_reviews do |t|
      t.string :ReviewType
      t.string :ReviewValue
      t.references :project, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
