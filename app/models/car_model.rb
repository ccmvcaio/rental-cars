class CarModel < ApplicationRecord
  belongs_to :car_category
  validates :name, :year, :fuel_type, :manufacturer, :motorization,
            :car_category, presence: true
end
