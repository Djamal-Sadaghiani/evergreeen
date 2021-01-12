# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_12_190635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "uuid"
    t.string "industry"
    t.string "description"
    t.string "sector"
    t.string "country_headquarter"
    t.integer "number_of_employees"
    t.string "website"
    t.string "phone_number"
    t.decimal "lat"
    t.decimal "lng"
    t.string "ticker", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticker"], name: "index_companies_on_ticker", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "currency_ISO"
    t.float "exchange_rate_to_EUR"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_ISO"], name: "index_currencies_on_currency_ISO", unique: true
  end

  create_table "income_statements", force: :cascade do |t|
    t.string "period"
    t.date "date"
    t.integer "total_revenue"
    t.integer "cost_of_revenue"
    t.integer "gross_profit"
    t.integer "operating_expense"
    t.integer "operating_income"
    t.integer "net_non_operating_interest_income_expense"
    t.integer "other_income_expense"
    t.integer "pretax_income"
    t.integer "tax_provision"
    t.integer "net_income_common_stockholders"
    t.integer "diluted_ni_available_to_com_stockholders"
    t.integer "basic_eps"
    t.integer "diluted_eps"
    t.integer "basic_average_shares"
    t.integer "diluted_average_shares"
    t.integer "total_operating_income_as_reported"
    t.integer "total_expenses"
    t.integer "net_income_from_continuing_and_discontinued_operation"
    t.integer "normalized_income"
    t.integer "interest_income"
    t.integer "interest_expense"
    t.integer "net_interest_income"
    t.integer "ebit"
    t.integer "ebitda"
    t.integer "reconciled_cost_of_revenue"
    t.integer "reconciled_depreciation"
    t.integer "net_income_from_continuing_operation_net_minority_interest"
    t.integer "normalized_ebitda"
    t.integer "tax_rate_for_calcs"
    t.integer "tax_effect_of_unusual_items"
    t.bigint "product_id"
    t.string "income_statement_uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["income_statement_uuid"], name: "index_income_statements_on_income_statement_uuid", unique: true
    t.index ["product_id"], name: "index_income_statements_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "isin", null: false
    t.string "name", null: false
    t.string "long_name"
    t.float "recommendations"
    t.integer "mean_target_price"
    t.integer "number_of_analysts"
    t.string "ticker"
    t.string "equity_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "currency_base"
    t.integer "price_yahoo"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["isin"], name: "index_products_on_isin", unique: true
  end

  create_table "trades", force: :cascade do |t|
    t.string "trade_uuid", null: false
    t.string "isin", null: false
    t.string "name", null: false
    t.datetime "time", null: false
    t.integer "price", null: false
    t.integer "amount", null: false
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_trades_on_product_id"
    t.index ["trade_uuid"], name: "index_trades_on_trade_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "income_statements", "products"
  add_foreign_key "products", "companies"
  add_foreign_key "trades", "products"
end
