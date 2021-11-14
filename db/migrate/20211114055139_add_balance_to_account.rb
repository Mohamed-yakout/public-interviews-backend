class AddBalanceToAccount < ActiveRecord::Migration[6.0]
  def change
    # Max balance 999,999.99
    add_column :accounts, :balance, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :accounts, :currency, :string, default: "AED"
  end
end
