class AddCodeToCharacteristicImage < ActiveRecord::Migration
  def change
    add_column :characteristic_images, :code, :string, after: :characteristic_id
  end
end
