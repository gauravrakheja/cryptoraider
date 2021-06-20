class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.string :currency
      t.decimal :units, precision: 30, scale: 14
      t.decimal :average_price, scale: 2, precision: 30

      t.timestamps
    end
  end
end
