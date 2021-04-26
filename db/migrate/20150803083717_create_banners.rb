class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.string :name
      t.string :image
      t.string :url

      t.timestamps null: false
    end
  end
end
