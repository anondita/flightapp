class CreateAirplanes < ActiveRecord::Migration[5.2]
  def change
    create_table :airplanes do |t|
      t.string :name
      t.string :typeofplane
      t.integer :firstseat
      t.integer :firstemer
      t.integer :firstprice
      t.integer :firstrow
      t.integer :busseat
      t.integer :busemer
      t.integer :busprice
      t.integer :busrow
      t.integer :ecoseat
      t.integer :ecoemer
      t.integer :ecoprice
      t.integer :ecorow

      t.timestamps
    end
  end
end
