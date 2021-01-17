# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :products
  has_many :events
  searchkick
end
