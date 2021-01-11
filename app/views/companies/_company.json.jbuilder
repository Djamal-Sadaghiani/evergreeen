json.extract! company, :id, :uuid, :industry, :description, :sector, :shares_outstanding, :headquarter, :employees,
              :created_at, :updated_at
json.url company_url(company, format: :json)
