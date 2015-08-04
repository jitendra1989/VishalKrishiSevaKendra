class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.boolean :outlet_only, default: false, null: false

      t.timestamps null: false
    end
  end
end
