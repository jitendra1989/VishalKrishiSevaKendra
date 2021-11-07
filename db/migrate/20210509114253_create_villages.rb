class CreateVillages < ActiveRecord::Migration[6.0]
  def change
    create_table :villages do |t|
      t.string :name
      t.timestamps
    end
  end
end
