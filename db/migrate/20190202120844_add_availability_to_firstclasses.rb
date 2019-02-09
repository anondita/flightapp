class AddAvailabilityToFirstclasses < ActiveRecord::Migration[5.2]
  def change
  	add_column :firstclasses, :availability, :integer
  end
end
