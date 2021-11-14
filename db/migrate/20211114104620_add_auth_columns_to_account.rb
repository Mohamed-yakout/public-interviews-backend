class AddAuthColumnsToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :encrypted_password, :string, allow_nil: false, default: ""
    add_column :accounts, :auth_token, :string
  end
end
