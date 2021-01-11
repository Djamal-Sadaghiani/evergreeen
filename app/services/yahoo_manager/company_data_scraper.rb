# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'geocoder'

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
      employees = get_employees()
      headquarter = get_country()
      website = get_website()
      phone_number = get_phone_number()
      lat, lng = get_location()

      a = {description: description, industry:industry, sector:sector, number_of_employees:employees, headquarter:headquarter, website:website, phone_number:phone_number, lat:lat, lng:lng}
    rescue StandardError
      {}
    end

    def get_companydata_by_ticker()
      url = "https://finance.yahoo.com/quote/#{@ticker}/profile?p=#{@ticker}"
      html_file = open(url).read
      Nokogiri::HTML(html_file)
    end

    def get_description()
      @data.css('p[data-reactid="217"]').first.text.strip
    end

    def get_industry()
      @data.xpath('//span[contains(@class, "Fw(600)")]')[1].text.strip
    end

    def get_employees()
      @data.xpath('//span[contains(@class, "Fw(600)")]')[2].text.strip.gsub(",", "").to_i
    end

    def get_sector()
      @data.xpath('//span[contains(@class, "Fw(600)")]').first.text.strip
    end

    def get_country()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[9].text.strip
    end
    
    def get_town()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[5].text.strip
    end

    def get_street()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[1].text.strip
    end
    
    def get_phone_number()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[12].text.strip
    end

    def get_website()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[14].text.strip
    end

    def get_location()
      address = get_street()+" "+get_town()+" "+get_country()
      Geocoder.search(address).first.coordinates

    end

  end
end
