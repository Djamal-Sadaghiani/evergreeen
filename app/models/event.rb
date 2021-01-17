# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :company
  validates :event_type, uniqueness: { scope: %i[date company] }
end
