class CreateCustomreviewrules < ActiveRecord::Migration[6.0]
  def change
    create_table :customreviewrules do |t|
      t.string :projectname
      t.string :reviewtype
      t.integer :numberoflinesincontroller
      t.integer :numberoflinesinmodel
      t.integer :numberoflinesinhelper
      t.integer :numberoflinesinview
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
