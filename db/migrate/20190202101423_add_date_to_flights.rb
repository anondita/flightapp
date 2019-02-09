class AddDateToFlights < ActiveRecord::Migration[5.2]
  def change
  	add_column :flights, :dateofflight, :date
  end
end
