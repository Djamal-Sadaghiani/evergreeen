# frozen_string_literal: true

module YahooManager
  class StockDataScraper < ApplicationService
    def initialize(params)
      @ticker = params[:ticker]
    end

    def call
      data = get_stockdata_by_ticker(@ticker)
      return if data['quoteSummary']['result'].nil?

      record = data['quoteSummary']['result'][0]['financialData']
      recommendations = record['recommendationMean']['raw']
      mean_target_price = record['targetMeanPrice']['raw'].to_f * 10_000
      price_yahoo = record['currentPrice']['raw'].to_f * 10_000
      number_of_analysts = record['numberOfAnalystOpinions']['fmt']
      { recommendations: recommendations, mean_target_price: mean_target_price,
        price_yahoo: price_yahoo, number_of_analysts: number_of_analysts }
    rescue StandardError
      {}
    end

    def get_stockdata_by_ticker(ticker)
      url = "https://query2.finance.yahoo.com/v10/finance/quoteSummary/#{ticker}?modules=financialData"
      JSON.parse(Curl.get(url).body_str)
    end
  end
end
