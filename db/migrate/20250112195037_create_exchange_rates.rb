class CreateExchangeRates < ActiveRecord::Migration[8.0]
  def change
    create_table :exchange_rates do |t|
      t.date :date
      t.string :currency
      t.decimal :rate, precision: 15, scale: 10

      t.timestamps
    end
  end
end
