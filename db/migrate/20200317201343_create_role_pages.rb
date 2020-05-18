class CreateRolePages < ActiveRecord::Migration[6.0]
  def change
    create_table :role_pages do |t|
      t.references :role_master, null: false, foreign_key: true
      t.references :page_master, null: false, foreign_key: true

      t.timestamps
    end
  end
end
