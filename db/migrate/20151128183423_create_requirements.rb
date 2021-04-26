class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.references :customer, index: true
      t.references :user, index: true
      t.references :outlet, index: true

      t.timestamps null: false
    end
    add_foreign_key :requirements, :customers
    add_foreign_key :requirements, :users
    add_foreign_key :requirements, :outlets
  end
end
