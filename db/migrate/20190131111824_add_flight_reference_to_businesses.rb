class AddFlightReferenceToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_reference :businesses, :flight, foreign_key: true
  end
end
