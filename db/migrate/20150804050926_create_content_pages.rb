class CreateContentPages < ActiveRecord::Migration
  def change
    create_table :content_pages do |t|
      t.string :title
      t.text :content
      t.string :slug

      t.timestamps null: false
    end
  end
end
