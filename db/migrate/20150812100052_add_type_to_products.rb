class AddTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type, :string, after: :active
  end
end
