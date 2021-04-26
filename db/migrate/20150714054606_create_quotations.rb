class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.references :customer, index: true
      t.references :user, index: true
      t.decimal :discount_amount, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :quotations, :customers
    add_foreign_key :quotations, :users
  end
end
