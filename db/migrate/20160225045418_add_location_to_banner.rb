class AddLocationToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :location, :integer, after: :url
  end
end
