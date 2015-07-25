class AddSlugToProducts < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string, after: :name
    add_index :products, :slug, unique: true
  end
end
