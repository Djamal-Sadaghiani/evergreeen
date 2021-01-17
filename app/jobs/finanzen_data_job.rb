# frozen_string_literal: true

require 'csv'

class FinanzenDataJob < ApplicationJob
  queue_as :default

  def perform
    Product.where("equity_type = 'EQUITY'").each do |product|
      data = FinanzenScraper.call(isin: product.isin)
      next if data.nil?

      product.shares_outstanding = data[:shares] unless data[:shares].nil?
      product.save unless data[:shares].nil?
      data[:events].each do |event|
        Event.create(
          event_type: event[:type],
          info: event[:info],
          date: event[:date],
          confirmed: event[:confirmed],
          company: product.company
        )
      end
    end
  end
end
