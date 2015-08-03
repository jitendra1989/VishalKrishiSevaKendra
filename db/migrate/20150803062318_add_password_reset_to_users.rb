class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string, after: :active
    add_column :users, :password_reset_sent_at, :datetime, after: :password_reset_token
  end
end
