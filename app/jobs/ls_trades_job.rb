# frozen_string_literal: true

require 'csv'

class LsTradesJob < ApplicationJob
  queue_as :default

  def perform
    download_trades
    last_trade = Trade.last&.time || Time.new(2000, 11, 1, 15, 25, 0, '+00:00')
    CSV.foreach('trades.csv', headers: true, liberal_parsing: true, quote_char: '"', col_sep: ';') do |row|
      if row[2].to_datetime > last_trade
        Trade.create(
          trade_uuid: row[5].to_s,
          isin: row[0].to_s,
          name: row[1].to_s,
          time: row[2].to_datetime,
          price: row[3].to_s.gsub(',', '').to_i,
          amount: row[4].to_i
        )
      end
    rescue StandardError
      next(row)
    end
    File.delete('trades.csv') if File.exist? 'trades.csv'
  end

  def download_trades
    `wget https://www.ls-x.de/_rpc/json/.lstc/instrument/list/lsxtradestoday -O trades.csv`
  end
end
