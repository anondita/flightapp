class AddAvailabilityToBusinesses < ActiveRecord::Migration[5.2]
  def change
  	add_column :businesses, :availability, :integer
  end
end
