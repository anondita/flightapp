class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.string :seatclass
      t.string :pnr
      t.integer :seatnumber
      t.string :seattype
      t.bigint :price
      t.integer :booking_id
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
