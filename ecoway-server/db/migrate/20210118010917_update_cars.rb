class UpdateCars < ActiveRecord::Migration[6.1]
  def change
    # Add new columns
    add_column :cars, :price, :decimal
    add_column :cars, :desc, :text
    add_column :cars, :odometer, :integer
    add_column :cars, :battery, :integer

    # Seed data with default values (not recommended for production)
    # This approach is for demonstration purposes only. In production, 
    # you'd likely populate data through other means like seeding or fixtures.
    Car.update_all(price: 5000, desc: '', odometer: 100000, battery: 330)

    # Remove this seed data section for production use
  end
end