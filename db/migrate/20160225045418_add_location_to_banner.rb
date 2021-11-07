class AddLocationToBanner < ActiveRecord::Migration[5.2]
  def change
    add_column :banners, :location, :integer, after: :url
  end
end
