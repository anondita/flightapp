json.extract! booking, :id, :pnr, :seats, :seatclass, :dateofjourney, :source, :destination, :user_id, :flight_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
