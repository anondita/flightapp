class AddFlightReferenceToEconomies < ActiveRecord::Migration[5.2]
  def change
    add_reference :economies, :flight, foreign_key: true
  end
end
