class AddImageToContentPages < ActiveRecord::Migration[5.2]
  def change
    add_column :content_pages, :image, :string, after: :title
  end
end
