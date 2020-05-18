class CreatePageMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :page_masters do |t|
      t.string :pagename
      t.string :pagelink

      t.timestamps
    end
  end
end
