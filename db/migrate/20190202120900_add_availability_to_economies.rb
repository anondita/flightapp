class AddAvailabilityToEconomies < ActiveRecord::Migration[5.2]
  def change
  	add_column :economies, :availability, :integer
  end
end
