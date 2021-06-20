class AddHighAndLowToCandles < ActiveRecord::Migration[6.1]
  def change
    add_column :candle_dumps, :high, :decimal, precision: 30, scale: 14
    add_column :candle_dumps, :low, :decimal, precision: 30, scale: 14
  end
end
