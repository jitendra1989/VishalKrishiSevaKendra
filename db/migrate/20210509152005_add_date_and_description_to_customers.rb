class AddDateAndDescriptionToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :cast_id, :integer
    add_column :customers, :village_id, :integer
    add_column :customers, :product_name, :string
    add_column :customers, :description, :text
    add_column :customers, :purchase_date, :date
  end
end
