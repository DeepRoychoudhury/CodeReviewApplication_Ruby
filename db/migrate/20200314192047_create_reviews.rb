class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :FileType
      t.string :ReviewName
      t.string :ReviewValue

      t.timestamps
    end
  end
end
