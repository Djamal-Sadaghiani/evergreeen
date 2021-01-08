# frozen_string_literal: true

module ProductAnalyzer
  class StockAnalyzer < ApplicationService
    def initialize(params)
      @price_potential = params[:price_potential]
      @number_of_analysts = params[:number_of_analysts]
    end

    def call
      if !@price_potential.nil? && !@number_of_analysts.nil?
        if @price_potential > 0.1 && @number_of_analysts > 3
          'BUY'
        elsif @price_potential.positive? && @number_of_analysts > 3
          'HOLD'
        elsif @price_potential.negative? && @number_of_analysts > 3
          'SELL'
        else
          'n/a'

        end
      end
    end
  end
end
