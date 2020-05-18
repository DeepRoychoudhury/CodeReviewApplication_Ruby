class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :ProjectName
      t.string :Path
      t.string :Status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
