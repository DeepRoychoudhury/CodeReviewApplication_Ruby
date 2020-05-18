class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :notepad
      t.string :notify
      t.references :project, null: false, foreign_key: true
    end
  end
end
