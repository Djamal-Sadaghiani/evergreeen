# frozen_string_literal: true

class AddCompanyIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :company, foreign_key: true
  end
end
