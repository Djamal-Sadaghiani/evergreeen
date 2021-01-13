# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'digest'
require 'kimurai'

class TradingviewDataScraper < ApplicationService
  def initialize(params)
    @ticker = params[:ticker]
  end

  def call
    @data = get_tradingview_data_by_ticker
    return if @data.nil?

    #tradingview_recommendation = get_recommendation
    #tradingview_net_recommendation_score = get_net_recommendation_score

    #{ tradingview_recommendation: tradingview_recommendation, tradingview_net_recommendation_score: tradingview_net_recommendation_score }
  end

  def get_tradingview_data_by_ticker
    url = "https://s.tradingview.com/embed-widget/technical-analysis/?locale=en#%7B%22interval%22%3A%221M%22%2C%22width%22%3A%22100%25%22%2C%22isTransparent%22%3Afalse%2C%22height%22%3A%22100%25%22%2C%22symbol%22%3A%22#{@ticker}%22%2C%22showIntervalTabs%22%3Atrue%2C%22colorTheme%22%3A%22dark%22%2C%22utm_medium%22%3A%22widget_new%22%2C%22utm_campaign%22%3A%22technical-analysis%22%7D"
    html_file = open(url).read
    p Nokogiri::HTML(html_file).text.strip
  end

  def get_recommendation
    #@data.xpath('//span[contains(@class, "speedometerSignal")]')
  end

  def get_net_recommendation_score
    positive = @data.xpath('//span[contains(@class, "counterNumber-3l14ys0C buyColor-4BaoBngr")]')&.text&.strip.to_f || 0 
    neutral = @data.xpath('//span[contains(@class, "counterNumber-3l14ys0C neutralColor-15OoMFX9")]')&.text&.strip.to_f || 0 
    negative = @data.xpath('//span[contains(@class, "counterNumber-3l14ys0C sellColor-2qa8ZOVt")]')&.text&.strip.to_f || 0 
    (positive - negative) / (positive + neutral + negative) if (positive + neutral + negative) > 0
  end

end
