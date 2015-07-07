class AddOutletToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :outlet, index: true, after: :country
    add_foreign_key :users, :outlets
  end
end
