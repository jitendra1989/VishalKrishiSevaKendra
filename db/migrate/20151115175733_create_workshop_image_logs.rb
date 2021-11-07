class CreateWorkshopImageLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :workshop_image_logs do |t|
      t.references :user, index: true
      t.string :info
      t.references :order_item_image_customisation, index: true

      t.timestamps null: false
    end
    add_foreign_key :workshop_image_logs, :users
    add_foreign_key :workshop_image_logs, :order_item_image_customisations
  end
end
