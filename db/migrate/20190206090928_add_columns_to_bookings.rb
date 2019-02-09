class AddColumnsToBookings < ActiveRecord::Migration[5.2]
  def change
  	add_column :bookings, :totalprice, :bigint
  end
end
