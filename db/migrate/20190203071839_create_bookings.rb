class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :pnr
      t.integer :seats
      t.string :seatclass
      t.date :dateofjourney
      t.string :source
      t.string :destination
      t.references :user, foreign_key: true
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
