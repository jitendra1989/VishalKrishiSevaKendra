class CreateBannerCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :banner_categories do |t|
      t.references :banner, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :banner_categories, :banners
    add_foreign_key :banner_categories, :categories
  end
end
