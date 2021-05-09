class CreateVilages < ActiveRecord::Migration[6.0]
  def change
    create_table :vilages do |t|
      t.string :name
      t.timestamps
    end
  end
end
