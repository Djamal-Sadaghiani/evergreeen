class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :info
      t.date :date
      t.boolean :confirmed
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
