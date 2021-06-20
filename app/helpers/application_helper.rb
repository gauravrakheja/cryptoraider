module ApplicationHelper
  def starting_price(candle_dumps)
    candle_dumps.min_by(&:occurred_at).price
  end

  def ending_price(candle_dumps)
    candle_dumps.max_by(&:occurred_at).price
  end
end
