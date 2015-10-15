class AddPasswordResetToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :password_reset_token, :string, after: :password_digest
    add_column :customers, :password_reset_sent_at, :datetime, after: :password_reset_token
  end
end
