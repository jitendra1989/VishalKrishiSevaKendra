class AddDetailsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :details, :text, after: :overridden
  end
end
