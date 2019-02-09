class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :name
      t.string :source
      t.string :destination
      t.time :depart
      t.time :arrive

      t.timestamps
    end
  end
end
