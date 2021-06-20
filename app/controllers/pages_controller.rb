class PagesController < ApplicationController
  def home; end

  def breakout
    if params[:wallet_id].present? &&
      params[:start_time].present? &&
      params[:end_time].present?
      @data = CandleDump.where(wallet_id: params[:wallet_id]).where("occurred_at AT TIME ZONE 'UTC' >= ? and occurred_at AT TIME ZONE 'UTC' <= ?", params[:start_time], params[:end_time])
      @candle_collection = CandleCollection.new(@data)
    end
  end
end