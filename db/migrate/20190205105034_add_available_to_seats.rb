class AddAvailableToSeats < ActiveRecord::Migration[5.2]
  def change
  	add_column :seats, :available,:boolean, default: true
  end
end
