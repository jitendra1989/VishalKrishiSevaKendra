class AddDetailsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :details, :text, after: :overridden
  end
end
