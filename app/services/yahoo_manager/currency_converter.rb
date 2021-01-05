module YahooManager
  class CurrencyConverter < ApplicationService
    def initialize(params)
      @currency = params[:currency]
      @amount = params[:amount]
    end

    #ISO code as input e.g. "USD"
    def call 
      url = "https://query1.finance.yahoo.com/v7/finance/spark?symbols=EUR#{@currency}%3DX&range=1d&interval=5m&indicators=close&includeTimestamps=false&includePrePost=false&corsDomain=de.finance.yahoo.com&.tsrc=finance" 
      data = JSON.parse(Curl.get(url).body_str)
      exchange_rate = data['spark']['result'][0]['response'][0]['meta']['regularMarketPrice']
      result = @amount / exchange_rate
    end
  end
  
end