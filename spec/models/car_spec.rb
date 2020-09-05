require 'rails_helper'

RSpec.describe Car, type: :model do
  describe ".description" do
    it 'should return car model name, color and license plate' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 50,
                                        third_party_insurance: 30)
      car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                                  motorization: '1.0', car_category: car_category,
                                  fuel_type: 'Flex')
      car = Car.new(license_plate: 'ABC123', color: 'Prata',
                        car_model: car_model, mileage: 0)

      result = car.description()

      expect(result).to eq 'Ka - Prata - ABC123'
    end
  end
end