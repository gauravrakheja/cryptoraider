class CandleCollection
  def initialize(candle_dumps)
    @candle_dumps = candle_dumps
  end

  def chart_data
    @chart_data ||= candle_dumps
                      .sort_by(&:occurred_at)
                      .map { |cd| { cd.occurred_at.utc.strftime("[%d-%m] [%I:%M %p]") => cd.price.to_f } }
                      .reduce({}, :merge)
  end

  def should_buy?
    last_consecutive_actions[0] > 1 &&
      last_consecutive_actions[1] > 0.5
  end

  def starting_price
    @starting_price ||= candle_dumps.min_by(&:occurred_at).price
  end

  def ending_price
    @ending_price ||= candle_dumps.max_by(&:occurred_at).price
  end

  def difference
    ((ending_price - starting_price)*100.00/starting_price)
      .round(3)
  end

  def minimum_price
    @minimum_price ||= candle_dumps.minimum(:price)
  end

  def candle_pairs
    result = []
    candle_dumps.sort_by(&:occurred_at).each_cons(2) do |first, second|
      result << CandlePair.new(first, second)
    end
    result
  end

  def last_consecutive_actions
    @last_consecutive_actions ||= calculate_last_consecutive_actions
  end

  private

  attr_reader :candle_dumps

  def calculate_last_consecutive_actions
    total_diff = 0
    action_count = 0
    candle_dumps.sort_by(&:occurred_at).reverse!.each_cons(2) do |first, second|
      current_diff = change(second, first).to_f.round(3)

      next if current_diff.zero?

      if current_diff.negative?
        if total_diff.negative? || total_diff.zero?
          action_count += 1
          total_diff += current_diff
        else
          return action_count, total_diff
        end
      else
        if total_diff.negative?
          return action_count, total_diff
        else
          action_count += 1
          total_diff += current_diff
        end
      end
    end

    [action_count, total_diff]
  end

  def change(cd1, cd2)
    ((cd2.price - cd1.price) * 100.00 / cd1.price).round(3)
  end
end