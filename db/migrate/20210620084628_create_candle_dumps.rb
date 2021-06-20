class CreateCandleDumps < ActiveRecord::Migration[6.1]
  def change
    create_table :candle_dumps do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :price, scale: 2, precision: 30
      t.timestamp :occurred_at

      t.timestamps
    end
  end
end
