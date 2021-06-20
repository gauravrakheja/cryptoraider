class CoindcxClient
  class << self
    API_SECRET         = "196b9d88bc773ad9e941d660151bde2cb348329191892ba3761e4f126f152c61"
    API_KEY            = "dd6eece30f0e2efe44319731be071cd2d9a8b02ba1d1e656"
    GET_BALANCE_URL    = "https://api.coindcx.com/exchange/v1/users/balances"
    MARKET_DETAILS_URL = "https://api.coindcx.com/exchange/v1/markets_details"
    CANDLE_URL         = "https://public.coindcx.com/market_data/candles"

    def user_balances
      body = body_with_timestamp

      JSON.parse(Excon.post(
        GET_BALANCE_URL,
        body: body,
        headers: authenticated_headers(body)
      ).body, symbolize_names: true)
    end

    def market_details
      JSON.parse(Excon.get(MARKET_DETAILS_URL).body, symbolize_names: true)
    end

    def candles(pair)
      JSON.parse(Excon.get(CANDLE_URL, query: { pair: pair, interval: '1m', startTime: 1624125720000 }).body, symbolize_names: true)
    end

    private

    def body_with_timestamp
      {
        "timestamp" => Time.now.to_i
      }.to_json
    end

    def authenticated_headers(payload)
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), API_SECRET, payload)

      {
        'Content-Type' => 'application/json',
        'X-AUTH-APIKEY' => API_KEY,
        'X-AUTH-SIGNATURE' => signature
      }
    end
  end
end