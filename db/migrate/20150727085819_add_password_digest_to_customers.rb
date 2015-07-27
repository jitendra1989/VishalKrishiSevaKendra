class AddPasswordDigestToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :password_digest, :string, after: :name
  end
end
