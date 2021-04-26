class CreateOutlets < ActiveRecord::Migration[5.2]
  def change
    create_table :outlets do |t|
      t.string :name
      t.string :country
      t.string :state
      t.string :city

      t.timestamps null: false
    end
  end
end
