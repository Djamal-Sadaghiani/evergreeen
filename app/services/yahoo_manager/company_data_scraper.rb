# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'geocoder'
require 'digest'

module YahooManager
  class CompanyDataScraper < ApplicationService
    def initialize(params)
      @ticker = params[:ticker]
    end

    def call
      @data = get_companydata_by_ticker
      return if @data.nil?

      description = get_description
      industry = get_industry
      sector = get_sector
      employees = get_employees
      headquarter = get_country
      website = get_website
      phone_number = get_phone_number
      lat = get_location&.first || 0
      lng = get_location&.second || 0
      uuid = Digest::MD5.hexdigest(description + ' ' + industry + ' ' + sector)
      address = get_address

      { description: description, industry: industry, sector: sector, number_of_employees: employees,
        headquarter: headquarter, website: website, phone_number: phone_number, lat: lat, lng: lng, uuid: uuid, address:address }
    end

    def get_companydata_by_ticker
      url = "https://finance.yahoo.com/quote/#{@ticker}/profile?p=#{@ticker}"
      html_file = open(url).read
      Nokogiri::HTML(html_file)
    end

    def get_description
      @data.xpath('//p[contains(@class, "Mt(15px) Lh(1.6)")]')&.text&.strip || ""
    end

    def get_industry
      @data.xpath('//span[contains(@class, "Fw(600)")]')[1]&.text&.strip || ""
    end

    def get_employees
      @data.xpath('//span[contains(@class, "Fw(600)")]')[2]&.text&.strip&.gsub(',', '').to_i  
    end

    def get_sector
      @data.xpath('//span[contains(@class, "Fw(600)")]').first&.text&.strip || ""
    end

    def get_country
      len = @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children.length()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[len-6]&.text&.strip || ""
    end

    def get_town
      len = @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children.length()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[len-10]&.text&.strip || ""
    end

    def get_street
      len = @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children.length()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[len-14]&.text&.strip || ""
    end

    def get_phone_number
      len = @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children.length()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[len-3]&.text&.strip
    end

    def get_website
      len = @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children.length()
      @data.xpath('//p[contains(@class, "D(ib) W(47.727%) Pend(40px)")]').children[len-1]&.text&.strip
    end

    def get_location
      Geocoder.search(get_address).first&.coordinates
    end

    def get_address
      (get_street + ' ' + get_town + ' ' + get_country)&.encode("iso-8859-1")&.force_encoding("utf-8") if !get_street.nil?
    end

  end
end
