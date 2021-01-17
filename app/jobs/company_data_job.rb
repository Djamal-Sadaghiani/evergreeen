# frozen_string_literal: true

class CompanyDataJob < ApplicationJob
  queue_as :yahoo

  def perform
    Company.all.order(updated_at: :asc).limit(800).each do |company|
      company_data = YahooManager::CompanyDataScraper.call(ticker: company.ticker)

      company.description = company_data&.dig(:description)
      company.industry = company_data&.dig(:industry)
      company.sector = company_data&.dig(:sector)
      company.number_of_employees = company_data&.dig(:number_of_employees)
      company.country_headquarter = company_data&.dig(:headquarter)
      company.country_code = company_data&.dig(:country_code)
      company.website = company_data&.dig(:website)
      company.phone_number = company_data&.dig(:phone_number)
      company.lat = company_data&.dig(:lat)
      company.lng = company_data&.dig(:lng)
      company.uuid = company_data&.dig(:uuid)
      company.address = company_data&.dig(:address)

      company.touch
      company.save
    end
  end
end
