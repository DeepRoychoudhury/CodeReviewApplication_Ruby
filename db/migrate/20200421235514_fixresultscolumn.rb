class Fixresultscolumn < ActiveRecord::Migration[6.0]
  def change
  	drop_table :results
  	
  	create_table :results do |t|
      t.string :Folder_Name
      t.string :Type_Of_File
      t.string :FileName
      t.integer :Error_Line_Number
      t.string :Error_Description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
