require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'token' do
    it 'generate token on create' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            car_category: car_category, user: user, client: client)

    rental.save!
    rental.reload

    expect(rental.token).to be_present
    expect(rental.token.length).to eq(6)
    expect(rental.token).to match(/^[A-Z0-9]+$/)
    end
  end
end
