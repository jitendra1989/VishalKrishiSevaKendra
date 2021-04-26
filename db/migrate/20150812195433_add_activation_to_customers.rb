class AddActivationToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :activation_digest, :string, after: :company_phone
    add_column :customers, :activated, :boolean, default: false, null: false, after: :activation_digest
    add_column :customers, :activated_at, :datetime, after: :activated
  end
end
