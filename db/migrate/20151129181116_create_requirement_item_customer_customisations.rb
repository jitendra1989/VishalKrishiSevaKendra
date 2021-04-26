class CreateRequirementItemCustomerCustomisations < ActiveRecord::Migration[5.2]
  def change
    create_table :requirement_item_customer_customisations do |t|
      t.references :requirement_item, index: { name: 'index_req_item_ricc' }
      t.string :name
      t.string :image
      t.string :code

      t.timestamps null: false
    end
    add_foreign_key :requirement_item_customer_customisations, :requirement_items
  end
end
