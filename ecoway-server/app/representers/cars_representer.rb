class CarsRepresenter
  def initialize(cars, user_id)
    @cars = cars
    @user_id = user_id
  end

  def as_json
    cars.map do |car|
      {
        id: car.id,
        owner: car.user.username,
        name: car_name(car),
        fav: favourite?(car.id, user_id),
        transmission: car.transmission,
        ac: ac?(car),
        battery: car.battery,
        odometer: car.odometer,
        color: car.color,
        price:car.price,
        max_seat_capacity: car.max_capacity,
        image: car.image_url,
        date_added: car.created_at
      }
    end
  end

  private

  def car_name(car)
    "#{car.make} #{car.model}"
  end

  def ac?(car)
    car.ac == 'true' ? 'Клімат контроль' : 'немає клімат контролю'
  end

  def favourite?(car_id, user_id)
    car = Car.find(car_id)
    car.favourites.where(user_id: user_id).count.zero? ? 'No' : 'Yes'
  end

  attr_reader :cars, :user_id
end
