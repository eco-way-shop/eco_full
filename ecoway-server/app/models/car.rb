class Car < ApplicationRecord
  belongs_to :user
  has_many :favourites
  has_many :test_drive

  validates :make, :model, :year, :color, :transmission, :ac, :image_url, :price, :odometer, :battery, :desc,  presence: true
end
