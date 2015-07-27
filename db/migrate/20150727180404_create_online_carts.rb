class CreateOnlineCarts < ActiveRecord::Migration
  def change
    create_table :online_carts do |t|
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :online_carts, :customers
  end
end
