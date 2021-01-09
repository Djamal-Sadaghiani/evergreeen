# frozen_string_literal: true

require 'curb'
require 'json'

module YahooManager
  class ProductDataScraper < ApplicationService
    def initialize(params)
      @isin = params[:isin]
    end

    def call
      base_url = 'https://query2.finance.yahoo.com/v1/finance/search?'
      params = { q: @isin, quotesCount: 1, newsCount: 0 }
      response = Curl.get(base_url, params)
      begin
        json = JSON.parse(response.body_str)
        ticker = json['quotes'][0]['symbol'] if json['quotes'][0]['symbol']
        equity_type = json['quotes'][0]['quoteType'] if json['quotes'][0]['quoteType']
        name = json['quotes'][0]['shortname'] if json['quotes'][0]['shortname']
        long_name = json['quotes'][0]['longname'] if json['quotes'][0]['longname']
        if equity_type == 'EQUITY'
          unless get_currency_base(ticker)['quoteResponse']['result'].nil?
            currency_base = get_currency_base(ticker)['quoteResponse']['result'][0]['currency']
          end
        end
        {ticker: ticker, equity_type: equity_type, name: name, long_name: long_name, currency_base: currency_base}
      rescue StandardError
        {}
      end
    end

    def get_currency_base(ticker)
      url = "https://query2.finance.yahoo.com/v7/finance/quote?formatted=true&crumb=HHMob3hrkL9&lang=de-DE&region=DE&symbols=#{ticker}&fields=messageBoardId%2ClongName%2CshortName%2CmarketCap%2CunderlyingSymbol%2CunderlyingExchangeSymbol%2CheadSymbolAsString%2CregularMarketPrice%2CregularMarketChange%2CregularMarketChangePercent%2CregularMarketVolume%2Cuuid%2CregularMarketOpen%2CfiftyTwoWeekLow%2CfiftyTwoWeekHigh%2CtoCurrency%2CfromCurrency%2CtoExchange%2CfromExchange&corsDomain=de.finance.yahoo.com"
      JSON.parse(Curl.get(url).body_str)
    end

  end
end
