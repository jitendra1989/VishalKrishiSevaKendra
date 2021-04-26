class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.integer :mobile, limit: 8
      t.integer :phone, limit: 8
      t.string :address
      t.integer :pincode
      t.string :city
      t.string :state
      t.string :country
      t.string :company_name
      t.string :company_address
      t.integer :company_phone, limit: 8

      t.timestamps null: false
    end
  end
end
