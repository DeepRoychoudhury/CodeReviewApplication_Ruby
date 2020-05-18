class CreateRoleMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :role_masters do |t|
      t.string :rolename

      t.timestamps
    end
  end
end
