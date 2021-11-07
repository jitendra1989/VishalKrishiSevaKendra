class AddDescriptionToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :description, :text, after: :name
  end
end
