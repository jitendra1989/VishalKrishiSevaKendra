class AddMenuOptionsToContentPages < ActiveRecord::Migration[5.2]
  def change
    add_column :content_pages, :menu, :boolean, default: false, null: false, after: :content
    add_column :content_pages, :link_text, :string, after: :menu
  end
end
