class AddConstraints < ActiveRecord::Migration[6.1]
  def change
    add_index :wallets, :currency, unique: true
    add_index :candle_dumps, [:occurred_at, :wallet_id], unique: true
  end
end
