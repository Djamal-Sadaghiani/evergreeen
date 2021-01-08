# frozen_string_literal: true

class VolumeCalculator < ApplicationService
  def initialize(params)
    @product = params[:product]
    @startdate = params[:startdate]
    @enddate = params[:enddate]
  end

  def call
    @product.trades.where(time: @startdate..@enddate).map do |trade|
      trade.price * trade.amount
    end.inject(0) { |sum, x| sum + x }
  end
end
