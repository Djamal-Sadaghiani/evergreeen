# frozen_string_literal: true

json.array! @trades, partial: 'trades/trade', as: :trade
