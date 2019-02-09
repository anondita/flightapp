class CreateEconomies < ActiveRecord::Migration[5.2]
  def change
    create_table :economies do |t|
      t.integer :seat
      t.integer :row
      t.integer :price
      t.integer :total
      t.integer :emergency

      t.timestamps
    end
  end
end
