class AddBalanceToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :balance, :decimal, default: 0.0
    add_column :accounts, :currency, :string, default: "AED"
  end
end
