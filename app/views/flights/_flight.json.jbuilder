json.extract! flight, :id, :name, :source, :destination, :depart, :arrive, :created_at, :updated_at
json.url flight_url(flight, format: :json)
