class AddOutletToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :outlet, index: true, after: :country
    add_foreign_key :users, :outlets
  end
end
