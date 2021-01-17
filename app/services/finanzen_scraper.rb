# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class FinanzenScraper < ApplicationService
  def initialize(params)
    @isin = params[:isin]
  end

  def call
    return if find_product.nil?
    # Check if we found the right page
    return unless @data.css("span[cpval=#{@isin}]").first['cpval'] == @isin

    shares = find_shares_outstanding&.to_i
    events = find_events
    { shares: shares, events: events }
  end

  def find_product
    url = "https://www.finanzen.net/suchergebnis.asp?_search=#{@isin}"
    html_file = open(url).read
    @data = Nokogiri::HTML(html_file)
  rescue StandardError
    nil
  end

  def find_shares_outstanding
    @data.at('td:contains("Anzahl Aktien in Mio.")').next_element.text.strip.gsub('.', '').gsub(',',
                                                                                                '.').to_f * 1_000_000
  rescue StandardError
    nil
  end

  def find_events
    url = "https://www.finanzen.net#{@data.search('#infoBoxTable').at('a:contains("Termine")')['href']}"
    html_file = open(url).read
    # File.write('test.html', html_file)
    data_events = Nokogiri::HTML(html_file)
    rows = data_events.xpath('//*[@itemtype="http://schema.org/Table"]').css('tr')
    return {} if rows.count <= 1

    begin
      rows[1..].map do |row|
        content = row.css('td').map do |cell|
          cell.text.strip
        end
        { type: content[0],
          info: content[2],
          date: Date.parse(content[3][0..9]),
          confirmed: is_event_confirmed?(content[3]) }
      end
    rescue StandardError
      []
    end
  end

  def is_event_confirmed?(date)
    !date.include?('(e)')
  end
end
