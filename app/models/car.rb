class Car < ApplicationRecord
  belongs_to :car_model
  has_many :car_rentals

  def description
    "#{car_model.name} - #{color} - #{license_plate}"
  end
end
