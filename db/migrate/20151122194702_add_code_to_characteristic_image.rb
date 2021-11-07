class AddCodeToCharacteristicImage < ActiveRecord::Migration[5.2]
  def change
    add_column :characteristic_images, :code, :string, after: :characteristic_id
  end
end
