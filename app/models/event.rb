class Event < ApplicationRecord
  belongs_to :company
  validates :event_type, uniqueness: { scope: [:date, :company] }
end
