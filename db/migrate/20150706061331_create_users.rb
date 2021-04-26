class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :email
      t.integer :phone, limit: 8
      t.string :address
      t.integer :pincode
      t.string :city
      t.string :state
      t.string :country
      t.boolean :active, null: false, default: false

      t.timestamps null: false

      t.index :username, unique: true
    end
  end
end
