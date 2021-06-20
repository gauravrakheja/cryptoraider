namespace :data_sync do
  IGNORED_WALLETS = %w[INR ADA BUSD]

  desc "Gets the list of wallets and stores them in the DB"
  task wallets: :environment do
    balances = CoindcxClient.user_balances

    balances
      .select {|balance| balance[:balance].to_f > 0}
      .each do |balance|

      next if IGNORED_WALLETS.include?(balance[:currency])

      Wallet
        .find_or_create_by!(currency: balance[:currency])
        .update(units: balance[:balance])
    end
  end

  desc "gets the latest trends for the currencies in the existing wallets"
  task candles: :environment do
    logger = Logger.new(STDOUT)

    market_details = CoindcxClient.market_details

    Wallet.find_each do |wallet|
      match = market_details.detect do |item|
        item[:base_currency_short_name] == 'INR' &&
          item[:target_currency_short_name] == wallet.currency
      end

      next unless match.present?

      logger.info("Storing candles for #{wallet.currency}")

      candles = CoindcxClient.candles(match[:pair]).compact

      candles.each do |candle|
        wallet.candle_dumps.find_or_create_by!(
          occurred_at: Time.at(candle[:time]/1000).utc.to_datetime
        ).update(price: candle[:close], high: candle[:high], low: candle[:low])
      end
    end
  end

end
