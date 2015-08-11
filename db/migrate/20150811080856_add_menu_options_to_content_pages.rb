class AddMenuOptionsToContentPages < ActiveRecord::Migration
  def change
    add_column :content_pages, :menu, :boolean, default: false, null: false, after: :content
    add_column :content_pages, :link_text, :string, after: :menu
  end
end
