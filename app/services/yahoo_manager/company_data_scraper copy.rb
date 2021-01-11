# frozen_string_literal: true

module YahooManager
  class CompanyDataScraper < ApplicationService
    def initialize(params)
      @ticker = params[:ticker]
    end

    def call
      @data = get_companydata_by_ticker()
      return if @data.nil?

      description = get_description()
      industry = get_industry()
      sector = get_sector()

      {description: description, industry:industry, sector:sector}
    rescue StandardError
      {}
    end

    def get_companydata_by_ticker()
      url = "https://de.finance.yahoo.com/quote/AMZN/profile?p=#{@ticker}"
    end

    def get_description()
      @data
    end

    def get_industry()
    end

    def get_sector()
    end

  end
end
