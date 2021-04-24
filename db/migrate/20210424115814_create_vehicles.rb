class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :Model
      t.integer :year
      t.integer :chassis_number
      t.string :color
      t.date :registration_date
      t.integer :odometer_reading
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
