class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :sender, index: true, foreign_key: {to_table: :accounts}
      t.references :receiver, index: true, foreign_key: {to_table: :accounts}

      t.decimal :amount, precision: 8, scale: 2, default: 0.0
      t.string :currency, default: "AED"

      t.timestamps
    end
  end
end
