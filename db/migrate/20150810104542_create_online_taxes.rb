class CreateOnlineTaxes < ActiveRecord::Migration
  def change
    create_table :online_taxes do |t|
      t.string :name
      t.float :percentage, null: false, default: 0.0

      t.timestamps null: false
    end
  end
end
