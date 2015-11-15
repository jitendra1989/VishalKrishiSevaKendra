class CreateWorkshopLogs < ActiveRecord::Migration
  def change
    create_table :workshop_logs do |t|
      t.references :user, index: true
      t.string :info
      t.references :order_item_customisation, index: true

      t.timestamps null: false
    end
    add_foreign_key :workshop_logs, :users
    add_foreign_key :workshop_logs, :order_item_customisations
  end
end
