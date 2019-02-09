json.extract! seat, :id, :seatclass, :pnr, :seatnumber, :seattype, :price, :flight_id, :booking_id, :created_at, :updated_at
json.url seat_url(seat, format: :json)
