class AddCountryCodeToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :country_code, :string
  end
end
