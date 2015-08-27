class AddImageToContentPages < ActiveRecord::Migration
  def change
    add_column :content_pages, :image, :string, after: :title
  end
end
