class Wallet < ApplicationRecord
  has_many :candle_dumps, dependent: :destroy
end
