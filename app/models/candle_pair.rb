class CandlePair
  def initialize(candle_one, candle_two)
    @candle_one = candle_one
    @candle_two = candle_two
  end

  def change
    @change ||= ((candle_two.price - candle_one.price)*100.00 / candle_one.price)
      .round(3)
  end

  def start_time
    format_time(candle_one.occurred_at)
  end

  def end_time
    format_time(candle_two.occurred_at)
  end

  def closing_price
    candle_two.price
  end

  private

  attr_reader :candle_one,
              :candle_two

  def format_time(timestamp)
    timestamp.utc.strftime("%d %b, %I:%M %p")
  end
end