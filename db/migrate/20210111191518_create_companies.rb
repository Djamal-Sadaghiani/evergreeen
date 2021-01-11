class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :uuid
      t.string :industry
      t.string :description
      t.string :sector
      t.string :country_headquarter
      t.integer :number_of_employees
      t.string :website
      t.string :phone_number
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
    add_index :companies, :uuid, unique: true
  end
end
